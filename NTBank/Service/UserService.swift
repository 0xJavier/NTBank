//
//  UserService.swift
//  NTBank
//
//  Created by Javier Munoz on 8/13/21.
//

import Foundation
import Firebase

class UserService {
    static let shared = UserService()
    
    private let playersRef = Firestore.firestore().collection(FirebaseType.players.rawValue)
    
    var userID: String? { return Auth.auth().currentUser?.uid }
    
    //MARK: - Init
    private init() { }
    
    func streamUser(completion: @escaping(Result<User, Error>) -> Void) {
        guard let userID = userID else {
            completion(.failure(NTError.couldNotGetUserID))
            return
        }
        
        playersRef.document(userID).addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                completion(.failure(error!))
                return
            }
            
            guard let data = document.data() else {
                completion(.failure(NTError.documentDataError))
                return
            }
            completion(.success(User(id: document.documentID, userInfo: data)))
        }
    }
    
    func streamUserTransactions(completion: @escaping(Result<[Transaction], Error>) -> Void) {
        guard let userID = userID else {
            completion(.failure(NTError.couldNotGetUserID))
            return
        }
        
        playersRef.document(userID).collection(FirebaseType.transactions.rawValue)
            .order(by: "id", descending: true)
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    completion(.failure(error!))
                    return
                }
                
                var transactions = [Transaction]()
                
                transactions.removeAll()
                
                for document in documents {
                    transactions.append(Transaction(transactionInfo: document.data()))
                }
                completion(.success(transactions))
            }
    }
    
    func changeUserCardColor(with color: String, completion: @escaping(Result<Bool, Error>) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {
            completion(.failure(NTError.couldNotGetUserID))
            return
        }
        
        let batch = Firestore.firestore().batch()
        
        let balanceRef = playersRef.document(userID)
        batch.updateData(["color": color], forDocument: balanceRef)
        
        batch.commit { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
}
