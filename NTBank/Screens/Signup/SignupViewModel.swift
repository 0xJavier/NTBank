//
//  SignupViewModel.swift
//  NTBank
//
//  Created by Javier Munoz on 12/5/21.
//

import Foundation
import Combine
import Firebase

@MainActor final class SignupViewModel: ObservableObject {
    
    @Published var state = State.loaded
    
    @Published var name = ""
    @Published var email = ""
    @Published var cardColor = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    var isValidPasswords: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest($password, $confirmPassword)
            .map { password, confirmPassword in
                return !password.isEmpty && password == confirmPassword
            }.eraseToAnyPublisher()
    }
    
    var validToSubmit: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest4($name, $email, $cardColor, isValidPasswords)
            .map { name, email, color, passwords in
                return !name.isEmpty && !email.isEmpty && !color.isEmpty && passwords
            }.eraseToAnyPublisher()
    }
    
    private var service: AuthServiceProtocol
    
    init(_ service: AuthServiceProtocol = AuthService()) {
        self.service = service
    }
    
    func createUser() async {
        do {
            try await service.createUser(with: email, and: password)
            guard let userID = Auth.auth().currentUser?.uid else { return }
            let user = User(userID: userID, name: name, email: email, balance: 1500, color: cardColor)
            try Firestore.firestore().collection(FirebaseType.players.rawValue).document(userID).setData(from: user)
            state = .success
        } catch {
            state = .error(error)
        }
    }
}
