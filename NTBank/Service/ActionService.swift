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
    private let playerRef = Firestore
        .firestore()
        .collection(FirebaseType.players.rawValue)
    
    private let lotteryRef = Firestore
        .firestore()
        .collection(FirebaseType.lottery.rawValue)
        .document(FirebaseType.balance.rawValue)
    
    var userID: String? {
        Auth.auth().currentUser?.uid
    }
    
    func collect200() async throws {
        guard let userID else { return }
        
        try await playerRef
            .document(userID)
            .updateData([FirebaseType.balance.rawValue : FieldValue.increment(Int64(200))])
        
        let transaction = Transaction(action: .collect200)
        
        try playerRef
            .document(userID)
            .collection(FirebaseType.transactions.rawValue)
            .document()
            .setData(from: transaction)
    }
    
    func sendMoney(to player: User, from user: User, _ amount: Int) async throws {
        // Sending Transaction
        let sendingTransaction = Transaction(action: .paidPlayer(player.name, amount))
        
        try await playerRef
            .document(user.userID)
            .updateData([FirebaseType.balance.rawValue : FieldValue.increment(Int64(-amount))])
        
        try playerRef
            .document(user.userID)
            .collection(FirebaseType.transactions.rawValue)
            .document()
            .setData(from: sendingTransaction)
        
        // Receiving Transaction
        let receivingTransaction = Transaction(action: .receivedMoneyFromPlayer(user.name, amount))
        
        try await playerRef
            .document(player.userID)
            .updateData([FirebaseType.balance.rawValue : FieldValue.increment(Int64(amount))])
        
        try playerRef
            .document(player.userID)
            .collection(FirebaseType.transactions.rawValue)
            .document()
            .setData(from: receivingTransaction)
    }
    
    func payBank(with amount: Int) async throws {
        guard let userID else { return }
        
        let transaction = Transaction(action: .paidBank(amount))
        
        try await playerRef
            .document(userID)
            .updateData([FirebaseType.balance.rawValue : FieldValue.increment(Int64(-amount))])
        
        try playerRef
            .document(userID)
            .collection(FirebaseType.transactions.rawValue)
            .document()
            .setData(from: transaction)
    }
    
    func payLottery(with amount: Int) async throws {
        guard let userID else { return }

        let transaction = Transaction(action: .paidLottery(amount))
        
        try await lotteryRef
            .updateData([TransactionModelType.amount.rawValue : FieldValue.increment(Int64(amount))])
        
        try await playerRef
            .document(userID)
            .updateData([FirebaseType.balance.rawValue : FieldValue.increment(Int64(-amount))])
        
        try playerRef
            .document(userID)
            .collection(FirebaseType.transactions.rawValue)
            .document()
            .setData(from: transaction)
    }
    
    func receiveMoney(with amount: Int) async throws {
        guard let userID else { return }

        let transaction = Transaction(action: .receivedMoneyFromBank(amount))
        
        try await playerRef
            .document(userID)
            .updateData([FirebaseType.balance.rawValue : FieldValue.increment(Int64(amount))])
        
        try playerRef
            .document(userID)
            .collection(FirebaseType.transactions.rawValue)
            .document()
            .setData(from: transaction)
    }
}
