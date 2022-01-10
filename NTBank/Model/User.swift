//
//  User.swift
//  NTBank
//
//  Created by Javier Munoz on 6/19/21.
//

import UIKit

struct User: Hashable, Codable {
    var userID: String = ""
    var name: String = ""
    var email: String = ""
    var balance: Int = 0
    var color: String = CardColor.blue.rawValue
    
    enum CodingKeys: String, CodingKey {
        case userID, name, email, balance, color
    }
    
    var colorLiteral: UIColor {
        let colorType = CardColor.init(rawValue: color)
        switch colorType {
        case .red:
            return .systemRed
        case .blue:
            return .systemBlue
        case .green:
            return .systemGreen
        case .pink:
            return .systemPink
        case .purple:
            return .systemPurple
        case .orange:
            return .systemOrange
        case .none:
            print("LOG: Error turning user color from string to colorLiteral. Defaulting to blue.")
            return .systemBlue
        }
    }
}

extension User {
    static let placeholder = User(userID: "12345", name: "", email: "", balance: 0, color: CardColor.blue.rawValue)
}
