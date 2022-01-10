//
//  AuthService.swift
//  NTBank
//
//  Created by Javier Munoz on 8/13/21.
//

import Foundation
import Firebase

protocol AuthServiceProtocol {
    func login(with email: String, and password: String) async throws
    func createUser(with email: String, and password: String) async throws
    func sendPasswordReset(with email: String) async throws
}

final class AuthService: AuthServiceProtocol {
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

//class AuthService {
//    static let shared = AuthService()
//
//    private init() { }
//
//    func login(with email: String, and password: String, completion: @escaping(Error?) -> Void) {
//        Auth.auth().signIn(withEmail: email, password: password) { authDataResult, error in
//            if let error = error {
//                completion(error)
//            } else {
//                completion(nil)
//            }
//        }
//    }
//
//    func createUser(with email: String, _ name: String, _ cardColor: String, and password: String, completion: @escaping(Error?) -> Void) {
//        Auth.auth().createUser(withEmail: email, password: password) { authDataResult, error in
//            if let error = error {
//                completion(error)
//            } else {
//                let data: [String:Any] = [
//                    UserType.email.rawValue: email.lowercased(),
//                    UserType.name.rawValue: name,
//                    UserType.balance.rawValue: 1500,
//                    UserType.color.rawValue: cardColor
//                ]
//                let batch = Firestore.firestore().batch()
//                guard let userID = Auth.auth().currentUser?.uid else { return }
//                let ref = Firestore.firestore().collection(FirebaseType.players.rawValue).document(userID)
//                batch.setData(data, forDocument: ref)
//                batch.commit(completion: completion)
//            }
//        }
//    }
//
//    func sendPasswordReset(with email: String, completion: @escaping(Error?) -> Void) {
//        Auth.auth().sendPasswordReset(withEmail: email, completion: completion)
//    }
//
//    func signout(completion: @escaping(Error?) -> Void) {
//        do {
//            try Auth.auth().signOut()
//            completion(nil)
//        } catch {
//            completion(NTError.couldNotLogout)
//        }
//    }
//}
