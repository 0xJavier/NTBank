//
//  SFSymbolType.swift
//  NTBank
//
//  Created by Javier Munoz on 8/20/21.
//

import UIKit

enum SFSymbolType: String, Codable {
    case paperPlane
    case dollarSign
    case building
    case car
    case chevronDown
    case creditCard
    case uturnArrow
    
    var image: UIImage {
        switch self {
        case .paperPlane: return UIImage(systemName: "paperplane.fill")!
        case .dollarSign: return UIImage(systemName: "dollarsign.square.fill")!
        case .building: return UIImage(systemName: "building.columns.fill")!
        case .car: return UIImage(systemName: "car.fill")!
        case .chevronDown: return UIImage(systemName: "chevron.down.square.fill")!
        case .creditCard: return UIImage(systemName: "creditcard.fill")!
        case .uturnArrow: return UIImage(systemName: "arrow.uturn.left")!
        }
    }
}

enum SFSymbols: String, Codable {
    case dollarSignCircle = "dollarsign.circle.fill"
    case dollarSignSquare = "dollarsign.square.fill"
    case house = "house"
    case personGroup = "person.2"
    case gear = "gear"
    case person = "person.fill"
    case buildingColumn = "building.columns.fill"
    case car = "car.fill"
    case paperPlane = "paperplane.fill"
    case chevronRight = "chevron.right"
    
    var image: UIImage {
        switch self {
        case .dollarSignCircle:
            UIImage(systemName: "dollarsign.square.fill")!
        case .dollarSignSquare:
            UIImage(systemName: "house")!
        case .house:
            UIImage(systemName: "person.2")!
        case .personGroup:
            UIImage(systemName: "gear")!
        case .gear:
            UIImage(systemName: "person.fill")!
        case .person:
            UIImage(systemName: "building.columns.fill")!
        case .buildingColumn:
            UIImage(systemName: "car.fill")!
        case .car:
            UIImage(systemName: "paperplane.fill")!
        case .paperPlane:
            UIImage(systemName: "chevron.right")!
        case .chevronRight:
            UIImage(systemName: "dollarsign.circle.fill")!
        }
    }
}
