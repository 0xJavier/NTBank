//
//  UIView+Extension.swift
//  NTBank
//
//  Created by Javier Munoz on 6/15/21.
//

import UIKit
import SwiftUI

extension UIView {
    public func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
    
    static func build<T: UIView>(_ builder: ((T) -> Void)? = nil) -> T {
        let view = T()
        view.translatesAutoresizingMaskIntoConstraints = false
        builder?(view)
        
        return view
    }
}

