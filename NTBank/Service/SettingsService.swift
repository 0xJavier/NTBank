//
//  SettingsService.swift
//  NTBank
//
//  Created by Javier Munoz on 12/5/21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol SettingsServiceProtocol {
    func fetchUser() async -> User
    func changeCardColor(with color: CardColor) async throws
}

final class SettingsService: SettingsServiceProtocol {
    private let playerRef = Firestore.firestore().collection(FirebaseType.players.rawValue)
    
    var userID: String? { return Auth.auth().currentUser?.uid }
    
    func fetchUser() async -> User {
        guard let userID = userID else {
            print("Error getting current userID [SettingService -> FetchUser]")
            return User.placeholder
        }
        do {
            let document = try await playerRef.document(userID).getDocument()
            let user = try document.data(as: User.self)
            return user ?? User.placeholder
        } catch {
            print("Error: \(error.localizedDescription)")
            return User.placeholder
        }
    }
    
    func changeCardColor(with color: CardColor) async throws {
        try await playerRef.document(userID!).setData([UserType.color.rawValue: color.rawValue], merge: true)
    }
}
