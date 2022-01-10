//
//  RankingViewModel.swift
//  NTBank
//
//  Created by Javier Munoz on 12/5/21.
//

import Foundation

@MainActor final class RankingViewModel {
    @Published var playersList = [User]()
    
    private var service: RankingServiceProtocol
    
    init(_ service: RankingServiceProtocol = RankingService()) {
        self.service = service
    }
    
    func fetchPlayers() async {
        playersList = await service.fetchAllPlayers()
    }
}
