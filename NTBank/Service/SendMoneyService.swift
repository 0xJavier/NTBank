//
//  SendMoneyService.swift
//  NTBank
//
//  Created by Javier Munoz on 12/9/21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol SendMoneyServiceProtocol {
    func fetchUsers() async -> [User]
    func sendMoney(to player: User, _ amount: Int) async throws
}

class SendMoneyService: SendMoneyServiceProtocol {
    private let playersRef = Firestore.firestore().collection(FirebaseType.players.rawValue)
    
    func fetchUsers() async -> [User] {
        do {
            guard let userID = Auth.auth().currentUser?.uid else { return [] }
            let snapshot = try await playersRef.getDocuments()
            var users = [User]()
            for document in snapshot.documents {
                guard let user = try document.data(as: User.self) else {
                    print("LOG: Error unwrapping users [RankingService -> fetchAllPlayers()]. Returning Empty array")
                    return []
                }
                if user.userID != userID { users.append(user) }
            }
            return users
        } catch {
            print("LOG: Error fetching players [SendMoneyService]: \(error.localizedDescription)")
            return []
        }
    }
    
    func sendMoney(to player: User, _ amount: Int) async throws {
        let currentUser = await fetchUser()
        
        let paidTransaction = Transaction(amount: -amount, action: "Paid \(player.name)", subAction: .Sent, type: .paidPlayer)
        try await playersRef.document(currentUser.userID).updateData([FirebaseType.balance.rawValue : FieldValue.increment(Int64(-amount))])
        try playersRef.document(currentUser.userID).collection(FirebaseType.transactions.rawValue).document().setData(from: paidTransaction)
        
        let receivedTransaction = Transaction(amount: amount, action: "Got paid from \(currentUser.name)", subAction: .Received, type: .receivedMoneyFromPlayer)
        try await playersRef.document(player.userID).updateData([FirebaseType.balance.rawValue : FieldValue.increment(Int64(amount))])
        try playersRef.document(player.userID).collection(FirebaseType.transactions.rawValue).document().setData(from: receivedTransaction)
    }
    
    private func fetchUser() async -> User {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("Error getting current userID [SendMoneyService -> FetchUser]")
            return User.placeholder
        }
        do {
            let document = try await Firestore.firestore().collection(FirebaseType.players.rawValue).document(userID).getDocument()
            let user = try document.data(as: User.self)
            return user ?? User.placeholder
        } catch {
            print("Error: \(error.localizedDescription)")
            return User.placeholder
        }
    }
}
