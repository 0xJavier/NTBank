//
//  User.swift
//  NTBank
//
//  Created by Javier Munoz on 6/19/21.
//

import UIKit

struct User: Hashable {
    var userID: String = ""
    var name: String = ""
    var email: String = ""
    var balance: Int = 0
    var color: String = CardColor.blue.rawValue
    
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
            print("Could not get color")
            return .systemBlue
        }
    }
    
    init(id: String, userInfo: [String:Any]) {
        self.userID = id
        self.name = userInfo[UserType.name.rawValue] as? String ?? ""
        self.email = userInfo[UserType.email.rawValue] as? String ?? ""
        self.color = userInfo[UserType.color.rawValue] as? String ?? ""
        self.balance = userInfo[UserType.balance.rawValue] as? Int ?? 0
    }
}

extension User {
    static let placeholder = User(id: "12345", userInfo: [UserType.name.rawValue: "Player",
                                                          UserType.email.rawValue: "player@NTBank.com",
                                                          UserType.color.rawValue: CardColor.red.rawValue,
                                                          UserType.balance.rawValue: 1500])
}
