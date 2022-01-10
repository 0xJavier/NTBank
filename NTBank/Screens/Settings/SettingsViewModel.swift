//
//  SettingsViewModel.swift
//  NTBank
//
//  Created by Javier Munoz on 12/5/21.
//

import Foundation
import Combine

@MainActor final class SettingsViewModel {
    @Published var user = User.placeholder
    
    var settings: [ImageAction] = [
        ImageAction(title: "Change Card Color", image: SFSymbolType.creditCard.image, backgroundColor: .systemBlue)
    ]
    
    private var service: SettingsServiceProtocol
    
    init(_ service: SettingsServiceProtocol = SettingsService()) {
        self.service = service
    }
    
    func fetchUser() async {
        self.user = await service.fetchUser()
    }
    
    func changeCardColor(with color: CardColor) async throws {
        try await service.changeCardColor(with: color)
        await fetchUser()
    }
}
