//
//  Transaction.swift
//  NTBank
//
//  Created by Javier Munoz on 6/19/21.
//

import Foundation
import FirebaseFirestore

struct Transaction: Codable {
    let title: String
    let subtitle: String
    let createdAt: Timestamp
    let amount: Int
    let icon: SFSymbols
}

extension Transaction {
    init(action: NTTransactionType) {
        self.createdAt = Timestamp()
        
        switch action {
        case .paidPlayer(let user, let amount):
            self.title = "Paid \(user.capitalized)"
            self.subtitle = "Sent"
            self.amount = -amount
            self.icon = .person
            
        case .receivedMoneyFromPlayer(let user, let amount):
            self.title = "Received money from \(user.capitalized)"
            self.subtitle = "Received"
            self.amount = amount
            self.icon = .person
            
        case .collect200:
            self.title = "Collected $200"
            self.subtitle = "Received"
            self.amount = 200
            self.icon = .dollarSignCircle
            
        case .paidBank(let amount):
            self.title = "Paid Bank"
            self.subtitle = "Sent"
            self.amount = -amount
            self.icon = .buildingColumn
            
        case .paidLottery(let amount):
            self.title = "Paid Lottery"
            self.subtitle = "Sent"
            self.amount = -amount
            self.icon = .car
            
        case .receivedMoneyFromBank(let amount):
            self.title = "Received money from Bank"
            self.subtitle = "Received"
            self.amount = amount
            self.icon = .buildingColumn
            
        case .wonLottery(let amount):
            self.title = "Won Lottery"
            self.subtitle = "Received"
            self.amount = amount
            self.icon = .dollarSignSquare
        }
    }
}
