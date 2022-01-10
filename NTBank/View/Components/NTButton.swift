//
//  NTButton.swift
//  NTBank
//
//  Created by Javier Munoz on 6/15/21.
//

import UIKit

final class NTButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String) {
        self.init(frame: .zero)
        self.setTitle(title, for: .normal)
    }
    
    private func configure() {
        configuration = .borderedProminent()
        //configuration?.cornerStyle = .medium
    }
}
