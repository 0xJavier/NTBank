//
//  NTSecurefield.swift
//  NTBank
//
//  Created by Javier Munoz on 6/15/21.
//

import UIKit

class NTSecurefield: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        configure()
    }
    
    convenience init(placeholder: String? = nil) {
        self.init(frame: .zero)
        self.placeholder = placeholder
        self.keyboardType = .default
        self.isSecureTextEntry = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        backgroundColor = .secondarySystemBackground
        autocorrectionType = .no
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: self.frame.height))
        leftViewMode = .always
    }
}
