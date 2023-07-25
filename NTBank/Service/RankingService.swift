//
//  RankingService.swift
//  NTBank
//
//  Created by Javier Munoz on 12/5/21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol RankingServiceProtocol {
    func fetchAllPlayers() async -> [User]
}

final class RankingService: RankingServiceProtocol {
    private let playersRef = Firestore.firestore().collection(FirebaseType.players.rawValue)
    
    func fetchAllPlayers() async -> [User] {
        do {
            let snapshot = try await playersRef.getDocuments()
            var users = [User]()
            for document in snapshot.documents {
                let user = try document.data(as: User.self)
//                guard let user = try document.data(as: User.self) else {
//                    print("LOG: Error unwrapping users [RankingService -> fetchAllPlayers()]. Returning Empty array")
//                    return []
//                }
                users.append(user)
            }
            users.sort { $0.balance > $1.balance }
            return users
        } catch {
            print("LOG: Error fetching players [RankingService]: \(error.localizedDescription)")
            return []
        }
    }
}
