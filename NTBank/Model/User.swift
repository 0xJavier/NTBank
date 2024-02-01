//
//  User.swift
//  NTBank
//
//  Created by Javier Munoz on 6/19/21.
//

import UIKit

struct User: Hashable, Codable {
    var userID: String
    var name: String
    var email: String
    var balance: Int = 0
    var color: CardColor = .blue
}

extension User {
    static let placeholder = User(
        userID: "12345",
        name: "",
        email: "",
        balance: 0,
        color: .blue
    )
}
