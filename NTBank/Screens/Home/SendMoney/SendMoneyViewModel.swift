//
//  SendMoneyViewModel.swift
//  NTBank
//
//  Created by Javier Munoz on 1/9/22.
//

import Foundation
import Combine

@MainActor final class SendMoneyViewModel {
    
    @Published var state = State.loaded
    
    @Published var playersList = [User]()
    @Published var selectedUser: User?
    @Published var amount = 0
    
    var validToSubmit: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest($selectedUser, $amount)
            .map { selectedUser, amount in
                return amount > 0 && selectedUser != nil
            }.eraseToAnyPublisher()
    }
    
    var service: SendMoneyServiceProtocol
    
    init(_ service: SendMoneyServiceProtocol = SendMoneyService()) {
        self.service = service
    }
    
    func fetchPlayers() async {
        playersList = await service.fetchUsers()
    }
    
    func sendMoney() async {
        guard let selectedUser = selectedUser else { return }
        
        do {
            try await service.sendMoney(to: selectedUser, amount)
            state = .success
        } catch {
            state = .error(error)
        }
    }
}
