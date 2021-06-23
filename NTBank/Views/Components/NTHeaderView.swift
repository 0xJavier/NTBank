//
//  NTHeaderView.swift
//  NTBank
//
//  Created by Javier Munoz on 6/15/21.
//

import UIKit

class NTHeaderView: UIView {
    
    var miniLogoImage: UIImageView = {
        let view = UIImageView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "miniLogo")
        
        return view
    }()
    
    var headerLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "NTBank"
        label.font = UIFont.systemFont(ofSize: 17)
        
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubviews(miniLogoImage, headerLabel)
        
        addConstraints()
    }
    
    private func addConstraints() {
        var constraints: [NSLayoutConstraint] = []
        
        constraints += createViewSizeConstraints()
        constraints += createLogoConstraints()
        constraints += createLabelConstraints()
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func createViewSizeConstraints() -> [NSLayoutConstraint] {
        let width = widthAnchor.constraint(equalToConstant: 111)
        let height = heightAnchor.constraint(equalToConstant: 30)
        
        return [width, height]
    }
    
    private func createLogoConstraints() -> [NSLayoutConstraint] {
        let top = miniLogoImage.topAnchor.constraint(equalTo: topAnchor)
        let leading = miniLogoImage.leadingAnchor.constraint(equalTo: leadingAnchor)
        let bottom = miniLogoImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        let width = miniLogoImage.widthAnchor.constraint(equalToConstant: 30)
        
        return [top, leading, bottom, width]
    }
    
    private func createLabelConstraints() -> [NSLayoutConstraint] {
        let top = headerLabel.topAnchor.constraint(equalTo: topAnchor)
        let leading = headerLabel.leadingAnchor.constraint(equalTo: miniLogoImage.trailingAnchor, constant: 10)
        let bottom = headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        let trailing = headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        
        return [top, leading, bottom, trailing]
    }
}
