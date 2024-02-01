//
//  TransactionService.swift
//  NTBank
//
//  Created by Javier Munoz on 12/9/21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import OSLog

protocol TransactionServiceProtocol {
    func streamUserTransactions(completion: @escaping(Result<[Transaction], Error>) -> Void)
}

final class TransactionService: TransactionServiceProtocol {
    private let playersRef = Firestore
        .firestore()
        .collection(FirebaseType.players.rawValue)
    
    var userID: String? {
        Auth.auth().currentUser?.uid
    }
    
    func streamUserTransactions(completion: @escaping (Result<[Transaction], Error>) -> Void) {
        guard let userID else {
            Logger.transactionService.error("Could not get UserID")
            return
        }
        
        playersRef.document(userID).collection(FirebaseType.transactions.rawValue)
            .order(by: "createdAt", descending: true)
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    Logger.transactionService.error("Could not get transactions")
                    return
                }
                
                let transactions = documents.compactMap { try? $0.data(as: Transaction.self) }
                completion(.success(transactions))
            }
    }
}
