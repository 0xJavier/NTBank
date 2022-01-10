//
//  Transaction.swift
//  NTBank
//
//  Created by Javier Munoz on 6/19/21.
//

import Foundation

struct Transaction: Codable {
    let amount: Int
    let action: String
    let subAction: String
    let type: String
    var id: Int = Int(Date().timeIntervalSince1970)
    
    enum CodingKeys: String, CodingKey {
        case id, amount, action, subAction, type
    }
        
    init(amount: Int, action: String, subAction: TransactionModelType, type: TransactionActionType) {
        self.amount = amount
        self.action = action
        self.subAction = subAction.rawValue
        self.type = type.rawValue
    }
}
