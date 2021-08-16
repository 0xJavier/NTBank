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
    let type: String
    var createdAt: Int = Int(Date().timeIntervalSince1970)
    
    var data: [String:Any] {
        return [
            "amount": amount,
            "action": action,
            "subAction": subAction,
            "type": TransactionType.collect200.rawValue,
            "id": Int(Date().timeIntervalSince1970)
        ]
    }

    init(amount: Int, action: String, subAction: String, type: TransactionType) {
        self.amount = amount
        self.action = action
        self.subAction = subAction
        self.type = type.rawValue
    }
    
    init(transactionInfo: [String:Any]) {
        self.amount = transactionInfo["amount"] as? Int ?? 0
        self.action = transactionInfo["action"] as? String ?? ""
        self.subAction = transactionInfo["subAction"] as? String ?? ""
        self.type = transactionInfo["type"] as? String ?? ""
        self.createdAt = transactionInfo["id"] as? Int ?? 0
    }
}
