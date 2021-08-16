//
//  GameService.swift
//  NTBank
//
//  Created by Javier Munoz on 8/13/21.
//

import Foundation
import Firebase

class GameService {
    static let shared = GameService()
    
    private let playersRef = Firestore.firestore().collection(FirebaseType.players.rawValue)
    
    private let lotteryRef = Firestore.firestore().collection(FirebaseType.lottery.rawValue).document(FirebaseType.balance.rawValue)
    
    var userID: String? { return Auth.auth().currentUser?.uid }
    
    private init() { }
    
    func getAllPlayers(completion: @escaping(Result<[User], Error>) -> Void) {
        playersRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            } else {
                var players = [User]()
                for document in querySnapshot!.documents {
                    players.append(User(id: document.documentID, userInfo: document.data()))
                }
                completion(.success(players))
            }
        }
    }
    
    func payBank(with amount: Int, completion: @escaping(Result<Bool, Error>) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {
            completion(.failure(NTError.couldNotGetUserID))
            return
        }
        let batch = Firestore.firestore().batch()
        
        let balanceRef = playersRef.document(userID)
        batch.updateData(["balance": FieldValue.increment(Int64(-amount))], forDocument: balanceRef)
        
        let transactionRef = playersRef.document(userID).collection(FirebaseType.transactions.rawValue).document()
        let transaction = Transaction(amount: -amount, action: "Paid Bank", subAction: "Sent", type: .paidBank)
        
        batch.setData(transaction.data, forDocument: transactionRef)
        
        batch.commit { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    func collect200(completion: @escaping(Result<Bool, Error>) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {
            completion(.failure(NTError.couldNotGetUserID))
            return
        }
        
        let batch = Firestore.firestore().batch()
        
        let balanceRef = playersRef.document(userID)
        batch.updateData(["balance": FieldValue.increment(Int64(200))], forDocument: balanceRef)
        
        let transactionRef = playersRef.document(userID).collection(FirebaseType.transactions.rawValue).document()
        
        let transaction = Transaction(amount: 200, action: "Collected $200", subAction: "Received", type: .collect200)
        
        batch.setData(transaction.data, forDocument: transactionRef)
        
        batch.commit { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    func receiveMoney(with amount: Int, completion: @escaping(Result<Bool, Error>) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {
            completion(.failure(NTError.couldNotGetUserID))
            return
        }
        
        let batch = Firestore.firestore().batch()
        
        let balanceRef = playersRef.document(userID)
        batch.updateData(["balance": FieldValue.increment(Int64(amount))], forDocument: balanceRef)
        
        let transactionRef = playersRef.document(userID).collection(FirebaseType.transactions.rawValue).document()
        let transaction = Transaction(amount: amount, action: "Got money from bank", subAction: "Received", type: .receivedMoneyFromBank)
        
        batch.setData(transaction.data, forDocument: transactionRef)
        
        batch.commit { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    func payLottery(with amount: Int, completion: @escaping((Result<Bool, Error>) -> Void)) {
        guard let userID = Auth.auth().currentUser?.uid else {
            completion(.failure(NTError.couldNotGetUserID))
            return
        }
        
        let batch = Firestore.firestore().batch()
        
        let balanceRef = playersRef.document(userID)
        batch.updateData(["balance": FieldValue.increment(Int64(-amount))], forDocument: balanceRef)
        
        let lotteryRef = Firestore.firestore().collection(FirebaseType.lottery.rawValue).document(FirebaseType.balance.rawValue)
        lotteryRef.updateData(["amount": FieldValue.increment(Int64(amount))])
        
        let transactionRef = playersRef.document(userID).collection(FirebaseType.transactions.rawValue).document()
        let transaction = Transaction(amount: -amount, action: "Paid Lottery", subAction: "Sent", type: .paidLottery)
        
        batch.setData(transaction.data, forDocument: transactionRef)
        
        batch.commit { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    func payPlayer(with amount: Int, from user: User, to player: User, completion: @escaping((Result<Bool, Error>) -> Void)) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let batch = Firestore.firestore().batch()
        
        let balanceRef = playersRef.document(userID)
        batch.updateData(["balance": FieldValue.increment(Int64(-amount))], forDocument: balanceRef)
        
        let transactionRef = playersRef.document(userID).collection(FirebaseType.transactions.rawValue).document()
        let firstTransaction = Transaction(amount: -amount, action: "Paid \(player.name)", subAction: "Sent", type: .paidPlayer)
        
        let balanceRefPlayer = playersRef.document(player.userID)
        batch.updateData(["balance": FieldValue.increment(Int64(amount))], forDocument: balanceRefPlayer)
        
        let transactionRefPlayer = playersRef.document(player.userID).collection(FirebaseType.transactions.rawValue).document()
        let secondTransaction = Transaction(amount: amount, action: "Got paid from \(user.name)", subAction: "Received", type: .receivedMoneyFromPlayer)
        
        batch.setData(firstTransaction.data, forDocument: transactionRef)
        batch.setData(secondTransaction.data, forDocument: transactionRefPlayer)
        
        batch.commit { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
}
