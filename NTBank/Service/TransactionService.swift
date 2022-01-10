//
//  TransactionService.swift
//  NTBank
//
//  Created by Javier Munoz on 12/9/21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol TransactionServiceProtocol {
    func streamUserTransactions(completion: @escaping(Result<[Transaction], Error>) -> Void)
}

final class TransactionService: TransactionServiceProtocol {
    
    private let playersRef = Firestore.firestore().collection(FirebaseType.players.rawValue)
    
    func streamUserTransactions(completion: @escaping (Result<[Transaction], Error>) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("COULD NOT GET ID")
            return
        }
        
        playersRef.document(userID).collection(FirebaseType.transactions.rawValue)
            .order(by: TransactionModelType.id.rawValue, descending: true)
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Could not get documents")
                    return
                }
                
                var transactions = [Transaction]()
                
                for document in documents {
                    if let transaction = try? document.data(as: Transaction.self) {
                        transactions.append(transaction)
                    }
                }
                
                completion(.success(transactions))
            }
    }
}
