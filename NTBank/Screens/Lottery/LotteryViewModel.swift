//
//  LotteryViewModel.swift
//  NTBank
//
//  Created by Javier Munoz on 12/5/21.
//

import Foundation
import Combine

@MainActor final class LotteryViewModel {
    
    @Published private(set) var state = State.loading
    @Published private(set) var amount = 0
    
    private var service: LotteryServiceProtocol
    
    init(_ service: LotteryServiceProtocol = LotteryService()) {
        self.service = service
    }
    
    func fetchLotteryAmount() async {
        await amount = service.fetchLottery()
        state = .loaded
    }
    
    func collectLottery() async {
        do {
            try await service.collectLottery(with: amount)
            state = .success
            await fetchLotteryAmount()
        } catch {
            state = .error(error)
        }
    }
}
