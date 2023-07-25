//
//  NTHeaderView.swift
//  NTBank
//
//  Created by Javier Munoz on 6/15/21.
//

import UIKit

final class NTHeaderView: UIView {
    
    lazy private var miniLogoImage: UIImageView = {
        let view = UIImageView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "miniLogo")
        
        return view
    }()
    
    lazy private var headerLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "NTBank"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .label
        
        return label
    }()
    
    //MARK: - Initializer
    init() {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Layout
    private func setupViews() {
        addSubviews(miniLogoImage, headerLabel)
        
        addConstraints()
    }
    
    private func addConstraints() {
        createViewSizeConstraints()
        createLogoConstraints()
        createLabelConstraints()
    }
    
    private func createViewSizeConstraints() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 111),
            heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    private func createLogoConstraints() {
        NSLayoutConstraint.activate([
            miniLogoImage.topAnchor.constraint(equalTo: topAnchor),
            miniLogoImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            miniLogoImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            miniLogoImage.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func createLabelConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: miniLogoImage.trailingAnchor, constant: 10),
            headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerLabel.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
}

#if DEBUG
import SwiftUI

struct NTHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            NTHeaderView()
        }
    }
}
#endif
