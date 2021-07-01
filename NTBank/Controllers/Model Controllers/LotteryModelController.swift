//
//  LotteryModelController.swift
//  NTBank
//
//  Created by Javier Munoz on 7/1/21.
//

import Foundation

protocol LotteryModelControllerDelegate: AnyObject {
    func didFetchLottery()
}

class LotteryModelController {
    public private(set) var amount = 0
    
    weak var lotteryDelegate: LotteryModelControllerDelegate?
    
    init() {
        streamLotteryAmount()
    }
    
    func streamLotteryAmount() {
        amount = 100
    }
    
    func collectLottery(completion: @escaping(() -> Void)) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            self.amount = 0
            completion()
        }
    }
}
