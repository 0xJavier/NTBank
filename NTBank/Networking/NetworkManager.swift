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
    
    private let lotteryRef = Firestore.firestore().collection("lottery").document("balance")
    
    var userID: String? {
        return Auth.auth().currentUser?.uid
    }
    
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
    
    func streamLottery(completion: @escaping(Int?) -> Void) {
        lotteryRef.addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("DEBUG: \(error?.localizedDescription ?? "Error getting document")")
                return
            }
            
            guard let data = document.data() else {
                print("DEBUG: Document data was empty")
                return
            }
            let amount = data["amount"] as? Int ?? 0
            completion(amount)
        }
    }
    
    func collectLottery(with amount: Int, completion: @escaping(Bool) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("DEBUG: Could not get userID when collecting lottery")
            completion(false)
            return
        }
        
        let batch = Firestore.firestore().batch()
        
        let userRef = Firestore.firestore().collection("players").document(userID)
        batch.updateData(["balance": FieldValue.increment(Int64(amount))], forDocument: userRef)
        
        let data: [String:Any] = [
            "id": Int(Date().timeIntervalSince1970),
            "amount": amount,
            "action": "Won the lottery",
            "subAction": "Recieved"
        ]
        
        let transactionRef = userRef.collection("transactions").document()
        batch.setData(data, forDocument: transactionRef)
        
        batch.updateData(["amount":0], forDocument: lotteryRef)
        
        batch.commit() { error in
            if let error = error {
                print("DEBUG: \(error.localizedDescription)")
                completion(false)
            } else {
                print("Success collecting Lottery")
                completion(true)
            }
        }
    }
    
    func getAllPlayers(completion: @escaping([User]?) -> Void) {
        playersRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("DEBUG: Error Getting Users. \(error.localizedDescription)")
                return
            } else {
                var players = [User]()
                for document in querySnapshot!.documents {
                    players.append(User(id: document.documentID, userInfo: document.data()))
                }
                completion(players)
            }
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
    
    func collect200(completion: @escaping(Bool) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let batch = Firestore.firestore().batch()
        
        let balanceRef = playersRef.document(userID)
        batch.updateData(["balance": FieldValue.increment(Int64(200))], forDocument: balanceRef)
        
        let transactionRef = playersRef.document(userID).collection("transactions").document()
        let data: [String:Any] = ["amount": 200,
                                  "action": "Collected $200",
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
    
    func payPlayer(with amount: Int, from user: User, to player: User, completion: @escaping((Bool) -> Void)) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let batch = Firestore.firestore().batch()
        
        let balanceRef = playersRef.document(userID)
        batch.updateData(["balance": FieldValue.increment(Int64(-amount))], forDocument: balanceRef)
        
        let transactionRef = playersRef.document(userID).collection("transactions").document()
        let data: [String:Any] = ["amount": -amount,
                                  "action": "Paid \(player.name)",
                                  "subAction": "Sent",
                                  "id": Int(Date().timeIntervalSince1970)]
        
        let balanceRefPlayer = playersRef.document(player.userID)
        batch.updateData(["balance": FieldValue.increment(Int64(amount))], forDocument: balanceRefPlayer)
        
        let transactionRefPlayer = playersRef.document(player.userID).collection("transactions").document()
        let dataPlayer: [String:Any] = ["amount": amount,
                                  "action": "Got paid from \(user.name)",
                                  "subAction": "Recieved",
                                  "id": Int(Date().timeIntervalSince1970)]
        
        batch.setData(data, forDocument: transactionRef)
        batch.setData(dataPlayer, forDocument: transactionRefPlayer)
        
        batch.commit { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                completion(true)
            }
        }
    }
}
