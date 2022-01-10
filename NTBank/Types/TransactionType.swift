//
//  TransactionType.swift
//  NTBank
//
//  Created by Javier Munoz on 8/5/21.
//

import Foundation

enum TransactionActionType: String {
    case paidPlayer
    case receivedMoneyFromPlayer
    case collect200
    case paidBank
    case paidLottery
    case receivedMoneyFromBank
    case wonLottery
}

enum TransactionModelType: String {
    case amount, action, subAction, type, id, Sent, Received
}
