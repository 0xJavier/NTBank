//
//  NTTransactionType.swift
//  NTBank
//
//  Created by Javier Munoz on 2/1/24.
//

import Foundation

enum NTTransactionType {
    case paidPlayer(String, Int)
    case receivedMoneyFromPlayer(String, Int)
    case collect200
    case paidBank(Int)
    case paidLottery(Int)
    case receivedMoneyFromBank(Int)
    case wonLottery(Int)
}
