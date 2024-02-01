//
//  IconViewModel.swift
//  NTBank
//
//  Created by Javier Munoz on 2/1/24.
//

import UIKit

struct IconViewModel {
    let icon: String
    let backgroundColor: UIColor
    
    init(symbol: SFSymbols) {
        self.icon = symbol.rawValue
        
        switch symbol {
        case .dollarSignCircle, .dollarSignSquare:
            self.backgroundColor = .systemRed
            
        case .person:
            self.backgroundColor = .systemBlue
            
        case .buildingColumn:
            self.backgroundColor = .systemGreen
            
        case .car:
            self.backgroundColor = .systemOrange
            
        default:
            self.backgroundColor = .systemBlue
        }
    }
}
