//
//  LoginViewModel.swift
//  NTBank
//
//  Created by Javier Munoz on 12/5/21.
//

import Foundation
import Combine

@MainActor final class LoginViewModel {
    
    @Published var state: LoginState = .loaded
    
    @Published var email = ""
    @Published var password = ""
    
    var validToSubmit: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest($email, $password)
            .map { email, password in
                return !email.isEmpty && !password.isEmpty
            }.eraseToAnyPublisher()
    }
    
    private var service: AuthServiceProtocol
    
    init(_ service: AuthServiceProtocol = AuthService()) {
        self.service = service
    }
    
    func login() async {
        do {
            try await service.login(with: email, and: password)
            state = .loginSuccessfull
        } catch {
            state = .failed(error)
        }
    }
    
    func sendPasswordReset(with email: String) async {
        do {
            try await service.sendPasswordReset(with: email)
            state = .forgotPasswordSuccessfull
        } catch {
            state = .failed(error)
        }
    }
}
