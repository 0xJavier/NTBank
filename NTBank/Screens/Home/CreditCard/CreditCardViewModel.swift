//
//  CreditCardViewModel.swift
//  NTBank
//
//  Created by Javier Munoz on 12/9/21.
//

import Foundation
import Combine

@MainActor final class CreditCardViewModel: ObservableObject {
    @Published var user = User.placeholder
    
    private var service: UserServiceProtocol
    
    init(_ service: UserServiceProtocol = UserService()) {
        self.service = service
        streamUser()
    }
    
    private func streamUser() {
        service.streamUser { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                self.user = user
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
