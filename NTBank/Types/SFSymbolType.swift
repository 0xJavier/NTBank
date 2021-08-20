//
//  SFSymbolType.swift
//  NTBank
//
//  Created by Javier Munoz on 8/20/21.
//

import UIKit

enum SFSymbolType: String {
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

