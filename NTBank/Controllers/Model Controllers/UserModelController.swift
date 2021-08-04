//
//  UserModelController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/19/21.
//

import Foundation
import Firebase

protocol UserModelControllerDelegate: AnyObject {
    func didFetchUser(user: User)
    func didFetchTransactions(transactions: [Transaction])
}

class UserModelController {
    public private(set) var user = UserMockData().user
    //public private(set) var transactions = UserMockData().transactions
    
    let playersRef = Firestore.firestore().collection("players")
    
    weak var userDelegate: UserModelControllerDelegate?
    
    init() {
        retrieveUser()
        retrieveTransactions()
    }
    
    func retrieveUser() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        playersRef.document(userID).addSnapshotListener { [weak self] documentSnapshot, error in
            guard let self = self else { return }
            
            guard let document = documentSnapshot else {
                print("DEBUG: \(error?.localizedDescription ?? "Error getting document")")
                return
            }
            
            guard let data = document.data() else {
                print("DEBUG: Document data was empty")
                return
            }
            self.user = User(id: document.documentID, userInfo: data)

            self.userDelegate?.didFetchUser(user: self.user)
        }
    }
    
    func retrieveTransactions() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        playersRef.document(userID).collection("transactions")
            .order(by: "id", descending: true)
            .addSnapshotListener { [weak self] querySnapshot, error in
                guard let self = self else { return }
                
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                
                //self.transactions.removeAll()
                
                for document in documents {
                    //self.transactions.append(Transaction(transactionInfo: document.data()))
                }
                //self.userDelegate?.didFetchTransactions(transactions: self.transactions)
            }
    }
}
