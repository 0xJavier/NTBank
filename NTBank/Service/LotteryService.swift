//
//  LotteryService.swift
//  NTBank
//
//  Created by Javier Munoz on 8/13/21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol LotteryServiceProtocol {
    func fetchLottery() async -> Int
    func collectLottery(with amount: Int) async throws
}

class LotteryService: LotteryServiceProtocol {
    private let userRef = Firestore.firestore().collection(FirebaseType.players.rawValue)
    private let lotteryRef = Firestore.firestore().collection(FirebaseType.lottery.rawValue).document(FirebaseType.balance.rawValue)
    
    func fetchLottery() async -> Int {
        do {
            let document = try await lotteryRef.getDocument()
            let amount = document.data()?["amount"] as? Int ?? 0
            return amount
        } catch {
            print("Error getting lottery amount [Lottery Service]: \(error.localizedDescription)")
            return 0
        }
    }
    
    func collectLottery(with amount: Int) async throws {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        do {
            try await userRef.document(userID).updateData([FirebaseType.balance.rawValue : FieldValue.increment(Int64(amount))])
            let transaction = Transaction(amount: amount, action: "Won the lottery", subAction: TransactionModelType.Received, type: TransactionActionType.wonLottery)
            try userRef.document(userID).collection(FirebaseType.transactions.rawValue).document().setData(from: transaction)
            try await lotteryRef.updateData([TransactionModelType.amount.rawValue : 0])
        } catch {
            print("Could not collect lottery: \(error.localizedDescription)")
        }
    }
}
