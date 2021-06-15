//
//  UIView+Extension.swift
//  NTBank
//
//  Created by Javier Munoz on 6/15/21.
//

import UIKit

extension UIView {
    public func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}
