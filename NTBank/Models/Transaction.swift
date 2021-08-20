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
            TransactionModelType.amount.rawValue: amount,
            TransactionModelType.action.rawValue: action,
            TransactionModelType.subAction.rawValue: subAction,
            TransactionModelType.type.rawValue: TransactionType.collect200.rawValue,
            TransactionModelType.id.rawValue: Int(Date().timeIntervalSince1970)
        ]
    }

    init(amount: Int, action: String, subAction: String, type: TransactionType) {
        self.amount = amount
        self.action = action
        self.subAction = subAction
        self.type = type.rawValue
    }
    
    init(transactionInfo: [String:Any]) {
        self.amount = transactionInfo[TransactionModelType.amount.rawValue] as? Int ?? 0
        self.action = transactionInfo[TransactionModelType.action.rawValue] as? String ?? ""
        self.subAction = transactionInfo[TransactionModelType.subAction.rawValue] as? String ?? ""
        self.type = transactionInfo[TransactionModelType.type.rawValue] as? String ?? ""
        self.createdAt = transactionInfo[TransactionModelType.id.rawValue] as? Int ?? 0
    }
}
