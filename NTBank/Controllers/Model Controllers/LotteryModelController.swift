//
//  LotteryModelController.swift
//  NTBank
//
//  Created by Javier Munoz on 7/1/21.
//

import Foundation
import Firebase

protocol LotteryModelControllerDelegate: AnyObject {
    func didFetchLottery()
}

class LotteryModelController {
    public private(set) var amount = 0
    
    let lotteryRef = Firestore.firestore().collection("lottery").document("balance")
    
    weak var lotteryDelegate: LotteryModelControllerDelegate?
    
    init() {
        retrieveLottery()
    }
    
    func retrieveLottery() {
        lotteryRef.addSnapshotListener { [weak self] documentSnapshot, error in
            guard let self = self else { return }
            
            guard let document = documentSnapshot else {
                print("DEBUG: \(error?.localizedDescription ?? "Error getting document")")
                return
            }
            
            guard let data = document.data() else {
                print("DEBUG: Document data was empty")
                return
            }
            self.amount = data["amount"] as? Int ?? 0
            self.lotteryDelegate?.didFetchLottery()
        }
    }
    
    func collectLottery(completion: @escaping(Bool) -> Void) {
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
}
