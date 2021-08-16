//
//  LotteryService.swift
//  NTBank
//
//  Created by Javier Munoz on 8/13/21.
//

import Foundation
import Firebase

class LotteryService {
    static let shared = LotteryService()
    
    private let lotteryRef = Firestore.firestore().collection(FirebaseType.lottery.rawValue).document(FirebaseType.balance.rawValue)
    
    var userID: String? { return Auth.auth().currentUser?.uid }
    
    private init() {  }
    
    func streamLottery(completion: @escaping(Result<Int, Error>) -> Void) {
        lotteryRef.addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                completion(.failure(error!))
                return
            }
            
            guard let data = document.data() else {
                completion(.failure(NTError.documentDataError))
                return
            }
            completion(.success(data["amount"] as? Int ?? 0))
        }
    }
    
    func collectLottery(with amount: Int, completion: @escaping(Result<Bool, Error>) -> Void) {
        guard let userID = userID else {
            completion(.failure(NTError.couldNotGetUserID))
            return
        }
        
        let batch = Firestore.firestore().batch()
        
        let userRef = Firestore.firestore().collection(FirebaseType.players.rawValue).document(userID)
        batch.updateData(["balance": FieldValue.increment(Int64(amount))], forDocument: userRef)
        
        let transaction = Transaction(amount: amount, action: "Won the lottery", subAction: "Received", type: .wonLottery)
        let transactionRef = userRef.collection(FirebaseType.transactions.rawValue).document()
        batch.setData(transaction.data, forDocument: transactionRef)
        
        batch.updateData(["amount":0], forDocument: lotteryRef)
        
        batch.commit() { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
}
