//
//  SettingsService.swift
//  NTBank
//
//  Created by Javier Munoz on 12/5/21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import OSLog

protocol SettingsServiceProtocol {
    func fetchUser() async -> User
    func changeCardColor(with color: CardColor) async throws
}

final class SettingsService: SettingsServiceProtocol {
    private let playerRef = Firestore.firestore().collection(FirebaseType.players.rawValue)
    
    var userID: String? { return Auth.auth().currentUser?.uid }
    
    func fetchUser() async -> User {
        guard let userID else {
            Logger.settingsService.error("Could not get current userID. Returning placeholder.")
            return User.placeholder
        }
        do {
            let document = try await playerRef.document(userID).getDocument()
            return try document.data(as: User.self)
        } catch {
            Logger.settingsService.error("Could not fetch / create user: \(error.localizedDescription)")
            return User.placeholder
        }
    }
    
    func changeCardColor(with color: CardColor) async throws {
        try await playerRef.document(userID!).setData([UserType.color.rawValue: color.rawValue], merge: true)
    }
}
