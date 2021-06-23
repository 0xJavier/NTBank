//
//  NTSymbolView.swift
//  NTBank
//
//  Created by Javier Munoz on 6/21/21.
//

import UIKit

class NTSymbolView: UIView {
    
    lazy var backgroundView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    lazy var symbolImageView: UIImageView = {
        let view = UIImageView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "person.fill")
        view.tintColor = .white
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        addSubviews(backgroundView)
        backgroundView.addSubview(symbolImageView)
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        var constraints: [NSLayoutConstraint] = []
        
        constraints += createBackgroundConstraints()
        constraints += createSymbolConstraints ()
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func createBackgroundConstraints() -> [NSLayoutConstraint] {
        let top = backgroundView.topAnchor.constraint(equalTo: topAnchor)
        let leading = backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor)
        let bottom = backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor)
        let trailing = backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor)
        
        return [top, leading, bottom, trailing]
    }
    
    private func createSymbolConstraints() -> [NSLayoutConstraint] {
        let centerX = symbolImageView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor)
        let centerY = symbolImageView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor)
        let width = symbolImageView.widthAnchor.constraint(equalToConstant: 20)
        let height = symbolImageView.heightAnchor.constraint(equalToConstant: 20)
        
        return [centerX, centerY, width, height]
    }
}
