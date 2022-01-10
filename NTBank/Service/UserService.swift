//
//  UserService.swift
//  NTBank
//
//  Created by Javier Munoz on 8/13/21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol UserServiceProtocol {
    func streamUser(completion: @escaping(Result<User, Error>) -> Void)
}

final class UserService: UserServiceProtocol {
    
    private let playersRef = Firestore.firestore().collection(FirebaseType.players.rawValue)
    
    var userID: String? { return Auth.auth().currentUser?.uid }
    
    func streamUser(completion: @escaping (Result<User, Error>) -> Void) {
        guard let userID = userID else { return }
        
        playersRef.document(userID).addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else { return }
            
            do {
                let user = try document.data(as: User.self)
                completion(.success(user ?? User.placeholder))
            } catch {
                print("Could not unwrap user")
                completion(.success(User.placeholder))
            }
        }
    }
}
