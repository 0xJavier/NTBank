//
//  LotteryService.swift
//  NTBank
//
//  Created by Javier Munoz on 8/13/21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import OSLog

protocol LotteryServiceProtocol {
    func fetchLottery() async -> Int
    func collectLottery(with amount: Int) async throws
}

class LotteryService: LotteryServiceProtocol {
    private let userQuery = Firestore
        .firestore()
        .collection(FirebaseType.players.rawValue)
    
    private let lotteryQuery = Firestore
        .firestore()
        .collection(FirebaseType.lottery.rawValue)
        .document(FirebaseType.balance.rawValue)
    
    var userID: String? {
        Auth.auth().currentUser?.uid
    }
    
    func fetchLottery() async -> Int {
        do {
            let document = try await lotteryQuery.getDocument()
            guard let amount = document.data()?["amount"] as? Int else {
                Logger.lotteryService.error("Could not unwrap document data as Int")
                return 0
            }
            return amount
        } catch {
            Logger.lotteryService.error("Could not fetch current lottery amount: \(error.localizedDescription)")
            return 0
        }
    }
    
    func collectLottery(with amount: Int) async throws {
        guard let userID else {
            Logger.lotteryService.error("Could not get current UserID")
            return
        }
        
        do {
            try await userQuery
                .document(userID)
                .updateData([FirebaseType.balance.rawValue : FieldValue.increment(Int64(amount))])
            
            let transaction = Transaction(action: .wonLottery(amount))
            try userQuery
                .document(userID)
                .collection(FirebaseType.transactions.rawValue)
                .document()
                .setData(from: transaction)
            
            try await lotteryQuery.updateData([TransactionModelType.amount.rawValue : 0])
        } catch {
            Logger.lotteryService.error("Could not collect lottery: \(error.localizedDescription)")
        }
    }
}
