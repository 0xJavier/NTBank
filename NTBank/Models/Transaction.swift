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
    let subAction: String
    let createdAt: Int
    
    init(amount: Int, action: String, subAction: String, createdAt: Int) {
        self.amount = amount
        self.action = action
        self.subAction = subAction
        self.createdAt = createdAt
    }
    
    init(transactionInfo: [String:Any]) {
        self.amount = transactionInfo["amount"] as? Int ?? 0
        self.action = transactionInfo["action"] as? String ?? ""
        self.subAction = transactionInfo["subAction"] as? String ?? ""
        self.createdAt = transactionInfo["id"] as? Int ?? 0
    }
}
