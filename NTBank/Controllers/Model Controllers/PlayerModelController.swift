//
//  PlayerModelController.swift
//  NTBank
//
//  Created by Javier Munoz on 7/14/21.
//

import Foundation
import Firebase

protocol PlayerModelControllerDelegate: AnyObject {
    func didFetchPlayers(players: [User])
}

class PlayerModelController {
    public private(set) var players = [User]()
    
    let playersRef = Firestore.firestore().collection("players")
    
    weak var playerDelegate: PlayerModelControllerDelegate?
    
    init() {
        retrievePlayers()
    }
    
    func retrievePlayers() {
        players.removeAll()
        
        playersRef.getDocuments { [weak self] (querySnapshot, error) in
            guard let self = self else { return }
            if let error = error {
                print("DEBUG: Error Getting Users. \(error.localizedDescription)")
                return
            } else {
                for document in querySnapshot!.documents {
                    self.players.append(User(id: document.documentID, userInfo: document.data()))
                }
                self.playerDelegate?.didFetchPlayers(players: self.players)
            }
        }
    }
}
