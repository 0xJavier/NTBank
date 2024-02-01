//
//  SendMoneyService.swift
//  NTBank
//
//  Created by Javier Munoz on 12/9/21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import OSLog

protocol SendMoneyServiceProtocol {
    func fetchUsers() async -> [User]
    func sendMoney(to player: User, _ amount: Int) async throws
}

class SendMoneyService: SendMoneyServiceProtocol {
    private let playersRef = Firestore
        .firestore()
        .collection(FirebaseType.players.rawValue)
    
    var userID: String? {
        Auth.auth().currentUser?.uid
    }
    
    func fetchUsers() async -> [User] {
        guard let userID else {
            Logger.sendMoneyService.error("Could not get current UserID")
            return []
        }
        
        let query = playersRef.whereField("id", isNotEqualTo: userID)
        
        do {
            let snapshot = try await query.getDocuments()
            return try snapshot.documents.compactMap{ try $0.data(as: User.self) }
        } catch {
            Logger.sendMoneyService.error("Could not fetch users: \(error.localizedDescription)")
            return []
        }
    }
    
    func sendMoney(to player: User, _ amount: Int) async throws {
        let currentUser = await fetchCurrentUser()

        let sendingTransaction = Transaction(action: .paidPlayer(player.name, amount))
        
        try await playersRef
            .document(currentUser.userID)
            .updateData([FirebaseType.balance.rawValue : FieldValue.increment(Int64(-amount))])
        
        try playersRef
            .document(currentUser.userID)
            .collection(FirebaseType.transactions.rawValue)
            .document()
            .setData(from: sendingTransaction)
        
        let receivingTransaction = Transaction(action: .receivedMoneyFromPlayer(currentUser.name, amount))
        
        try await playersRef
            .document(player.userID)
            .updateData([FirebaseType.balance.rawValue : FieldValue.increment(Int64(amount))])
        
        try playersRef
            .document(player.userID)
            .collection(FirebaseType.transactions.rawValue)
            .document()
            .setData(from: receivingTransaction)
    }
    
    private func fetchCurrentUser() async -> User {
        guard let userID else {
            Logger.sendMoneyService.error("Could not get current UserID. Returning placeholder")
            return .placeholder
        }
        
        do {
            let document = try await Firestore
                .firestore()
                .collection(FirebaseType.players.rawValue)
                .document(userID)
                .getDocument()
            
            return try document.data(as: User.self)
        } catch {
            Logger.sendMoneyService.error("Could not get/unwrap user: \(error.localizedDescription)")
            return .placeholder
        }
    }
}
