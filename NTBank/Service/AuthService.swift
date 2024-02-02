//
//  AuthService.swift
//  NTBank
//
//  Created by Javier Munoz on 8/13/21.
//

import Foundation
import Firebase

protocol AuthServiceProtocol {
    var isUserLoggedIn: Bool { get }
    func login(with email: String, and password: String) async throws
    func createUser(with email: String, and password: String) async throws
    func sendPasswordReset(with email: String) async throws
}

final class AuthService: AuthServiceProtocol {
    var isUserLoggedIn: Bool {
        Auth.auth().currentUser?.uid != nil
    }
    
    func login(with email: String, and password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func createUser(with email: String, and password: String) async throws {
        try await Auth.auth().createUser(withEmail: email, password: password)
    }
    
    func sendPasswordReset(with email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
}
