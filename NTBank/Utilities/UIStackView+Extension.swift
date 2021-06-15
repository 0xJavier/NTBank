//
//  UIStackView+Extension.swift
//  NTBank
//
//  Created by Javier Munoz on 6/15/21.
//

import UIKit

extension UIStackView {
    public func addArrangedSubviews(_ views: UIView...) {
        for view in views { addArrangedSubview(view) }
    }
}
