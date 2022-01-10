//
//  ActionViewModel.swift
//  NTBank
//
//  Created by Javier Munoz on 12/9/21.
//

import Foundation
import Combine

@MainActor final class ActionViewModel: ObservableObject {
    let actions: [ImageAction] = [
        ImageAction(title: "Send Money", image: SFSymbolType.paperPlane.image, backgroundColor: .systemBlue),
        ImageAction(title: "Collect $200", image: SFSymbolType.dollarSign.image, backgroundColor: .systemPink),
        ImageAction(title: "Pay Bank", image: SFSymbolType.building.image, backgroundColor: .systemGreen),
        ImageAction(title: "Pay Lottery", image: SFSymbolType.car.image, backgroundColor: .systemOrange),
        ImageAction(title: "Receive Money", image: SFSymbolType.chevronDown.image, backgroundColor: .systemPurple)
    ]
    
    @Published var state = State.loaded
    
    private var service: ActionServiceProtocol
    
    init(_ service: ActionServiceProtocol = ActionService()) {
        self.service = service
    }
    
    func sendMoney(to player: User, from user: User, _ amount: Int) async throws {
        try await service.sendMoney(to: player, from: user, amount)
    }
    
    func collect200() async {
        do {
            try await service.collect200()
            state = .success
        } catch {
            state = .error(error)
        }
    }
    
    func payBank(with amount: Int) async {
        do {
            try await service.payBank(with: amount)
            state = .success
        } catch {
            state = .error(error)
        }
    }
    
    func payLottery(with amount: Int) async {
        do {
            try await service.payLottery(with: amount)
            state = .success
        } catch {
            state = .error(error)
        }
    }
    
    func receiveMoney(with amount: Int) async {
        do {
            try await service.receiveMoney(with: amount)
            state = .success
        } catch {
            state = .error(error)
        }
    }
}
