//
//  Transaction.swift
//  NTBank
//
//  Created by Javier Munoz on 6/19/21.
//

import Foundation

struct Transaction {
    let amount: Int
    let action: String
    let createdAt: Int
    
    init(amount: Int, action: String, createdAt: Int) {
        self.amount = amount
        self.action = action
        self.createdAt = createdAt
    }
    
    init(transactionInfo: [String:Any]) {
        self.amount = transactionInfo["amount"] as? Int ?? 0
        self.action = transactionInfo["action"] as? String ?? ""
        self.createdAt = transactionInfo["id"] as? Int ?? 0
    }
}
