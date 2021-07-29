//
//  NetworkManager.swift
//  NTBank
//
//  Created by Javier Munoz on 7/29/21.
//

import Foundation
import Firebase

class NetworkManager {
    static let shared = NetworkManager()
    
    private let playersRef = Firestore.firestore().collection("players")
    
    private init() { }
    
    //MARK:-
    func streamUser(completion: @escaping(User?) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("COULD NOT LOAD USERID")
            return
        }
        
        playersRef.document(userID).addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("DEBUG: \(error?.localizedDescription ?? "Error getting document")")
                return
            }
            
            guard let data = document.data() else {
                print("DEBUG: Document data was empty")
                return
            }
            completion(User(id: document.documentID, userInfo: data))
        }
    }
    
    func streamUserTransactions(completion: @escaping([Transaction]?) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        playersRef.document(userID).collection("transactions")
            .order(by: "id", descending: true)
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                
                var transactions = [Transaction]()
                
                transactions.removeAll()
                
                for document in documents {
                    transactions.append(Transaction(transactionInfo: document.data()))
                }
                completion(transactions)
            }
    }
    
    func payBank(with amount: Int, completion: @escaping(Bool) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let batch = Firestore.firestore().batch()
        
        let balanceRef = playersRef.document(userID)
        batch.updateData(["balance": FieldValue.increment(Int64(-amount))], forDocument: balanceRef)
        
        let transactionRef = playersRef.document(userID).collection("transactions").document()
        let data: [String:Any] = ["amount": -amount,
                                  "action": "Paid Bank",
                                  "subAction": "Sent",
                                  "id": Int(Date().timeIntervalSince1970)]
        batch.setData(data, forDocument: transactionRef)
        
        batch.commit { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                completion(true)
            }
        }
    }
    
    func recieveMoney(with amount: Int, completion: @escaping(Bool) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let batch = Firestore.firestore().batch()
        
        let balanceRef = playersRef.document(userID)
        batch.updateData(["balance": FieldValue.increment(Int64(amount))], forDocument: balanceRef)
        
        let transactionRef = playersRef.document(userID).collection("transactions").document()
        let data: [String:Any] = ["amount": amount,
                                  "action": "Got money from Bank",
                                  "subAction": "Recieved",
                                  "id": Int(Date().timeIntervalSince1970)]
        batch.setData(data, forDocument: transactionRef)
        
        batch.commit { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                completion(true)
            }
        }
    }
    
    func payLottery(with amount: Int, completion: @escaping((Bool) -> Void)) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let batch = Firestore.firestore().batch()
        
        let balanceRef = playersRef.document(userID)
        batch.updateData(["balance": FieldValue.increment(Int64(-amount))], forDocument: balanceRef)
        
        let lotteryRef = Firestore.firestore().collection("lottery").document("balance")
        lotteryRef.updateData(["amount": FieldValue.increment(Int64(amount))])
        
        let transactionRef = playersRef.document(userID).collection("transactions").document()
        let data: [String:Any] = ["amount": -amount,
                                  "action": "Paid Lottery",
                                  "subAction": "Sent",
                                  "id": Int(Date().timeIntervalSince1970)]
        batch.setData(data, forDocument: transactionRef)
        
        batch.commit { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                completion(true)
            }
        }
    }
}
