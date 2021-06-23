//
//  UIViewController+Extension.swift
//  NTBank
//
//  Created by Javier Munoz on 6/19/21.
//

import UIKit

extension UIViewController {
    //MARK: -
    public func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    //MARK: -
    public func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        self.view.addGestureRecognizer(tap)
    }
}
