//
//  RankingService.swift
//  NTBank
//
//  Created by Javier Munoz on 12/5/21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import OSLog

protocol RankingServiceProtocol {
    func fetchAllPlayers() async -> [User]
}

final class RankingService: RankingServiceProtocol {
    private let query = Firestore
        .firestore()
        .collection(FirebaseType.players.rawValue)
        .order(by: FirebaseType.balance.rawValue, descending: true)
    
    func fetchAllPlayers() async -> [User] {
        do {
            let snapshot = try await query.getDocuments()
            return try snapshot.documents.compactMap { try $0.data(as: User.self) }
        } catch {
            Logger.rankingService.error("Could not fetch/create users: \(error.localizedDescription)")
            return []
        }
    }
}
