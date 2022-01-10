//
//  ActionService.swift
//  NTBank
//
//  Created by Javier Munoz on 12/9/21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol ActionServiceProtocol {
    func sendMoney(to player: User, from user: User, _ amount: Int) async throws
    func collect200() async throws
    func payBank(with amount: Int) async throws
    func payLottery(with amount: Int) async throws
    func receiveMoney(with amount: Int) async throws
}

final class ActionService: ActionServiceProtocol {
    private let playerRef = Firestore.firestore().collection(FirebaseType.players.rawValue)
    private let lotteryRef = Firestore.firestore().collection(FirebaseType.lottery.rawValue).document(FirebaseType.balance.rawValue)
    
    func collect200() async throws {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        try await playerRef.document(userID).updateData([FirebaseType.balance.rawValue : FieldValue.increment(Int64(200))])
        let transaction = Transaction(amount: 200, action: "Collected $200", subAction: .Received, type: .collect200)
        try playerRef.document(userID).collection(FirebaseType.transactions.rawValue).document().setData(from: transaction)
    }
    
    func sendMoney(to player: User, from user: User, _ amount: Int) async throws {
        let paidTransaction = Transaction(amount: -amount, action: "Paid \(player.name)", subAction: .Sent, type: .paidPlayer)
        try await playerRef.document(user.userID).updateData([FirebaseType.balance.rawValue : FieldValue.increment(Int64(-amount))])
        try playerRef.document(user.userID).collection(FirebaseType.transactions.rawValue).document().setData(from: paidTransaction)
        
        let receivedTransaction = Transaction(amount: amount, action: "Got paid from \(user.name)", subAction: .Received, type: .receivedMoneyFromPlayer)
        try await playerRef.document(player.userID).updateData([FirebaseType.balance.rawValue : FieldValue.increment(Int64(amount))])
        try playerRef.document(player.userID).collection(FirebaseType.transactions.rawValue).document().setData(from: receivedTransaction)
    }
    
    func payBank(with amount: Int) async throws {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        let transaction = Transaction(amount: -amount, action: "Paid Bank", subAction: .Sent, type: .paidBank)
        try await playerRef.document(userID).updateData([FirebaseType.balance.rawValue : FieldValue.increment(Int64(-amount))])
        try playerRef.document(userID).collection(FirebaseType.transactions.rawValue).document().setData(from: transaction)
    }
    
    func payLottery(with amount: Int) async throws {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        let transaction = Transaction(amount: -amount, action: "Paid Lottery", subAction: .Sent, type: .paidLottery)
        try await lotteryRef.updateData([TransactionModelType.amount.rawValue : FieldValue.increment(Int64(amount))])
        try await playerRef.document(userID).updateData([FirebaseType.balance.rawValue : FieldValue.increment(Int64(-amount))])
        try playerRef.document(userID).collection(FirebaseType.transactions.rawValue).document().setData(from: transaction)
    }
    
    func receiveMoney(with amount: Int) async throws {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        let transaction = Transaction(amount: amount, action: "Got paid from Bank", subAction: .Received, type: .receivedMoneyFromBank)
        try await playerRef.document(userID).updateData([FirebaseType.balance.rawValue : FieldValue.increment(Int64(amount))])
        try playerRef.document(userID).collection(FirebaseType.transactions.rawValue).document().setData(from: transaction)
    }
}
