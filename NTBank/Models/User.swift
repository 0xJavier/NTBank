//
//  User.swift
//  NTBank
//
//  Created by Javier Munoz on 6/19/21.
//

import UIKit

struct User {
    var userID: String = ""
    var name: String = ""
    var email: String = ""
    var balance: Int = 0
    var color: String = "blue"
    
    var colorLiteral: UIColor {
        switch color {
        case "red":
            return UIColor.systemRed
        case "blue":
            return UIColor.systemBlue
        case "green":
            return UIColor.systemGreen
        case "pink":
            return UIColor.systemPink
        case "purple":
            return UIColor.systemPurple
        case "orange":
            return UIColor.systemOrange
        default:
            print("Could not get color")
            return UIColor.systemBlue
        }
    }
    
    init(id: String, userInfo: [String:Any]) {
        self.userID = id
        self.name = userInfo["name"] as? String ?? ""
        self.email = userInfo["email"] as? String ?? ""
        self.color = userInfo["color"] as? String ?? ""
        self.balance = userInfo["balance"] as? Int ?? 0
    }
}
