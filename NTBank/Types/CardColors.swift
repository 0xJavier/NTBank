//
//  CardColors.swift
//  NTBank
//
//  Created by Javier Munoz on 8/6/21.
//

import UIKit

enum CardColor: String, CaseIterable, Codable {
    case red, blue, green, pink, purple, orange
    
    var uiColor: UIColor {
        switch self {
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
        }
    }
}
