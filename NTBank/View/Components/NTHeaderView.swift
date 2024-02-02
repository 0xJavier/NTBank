//
//  NTHeaderView.swift
//  NTBank
//
//  Created by Javier Munoz on 6/15/21.
//

import UIKit

final class NTHeaderView: UIView {
    lazy private var miniLogoImage: UIImageView = .build { view in
        view.image = UIImage(resource: .miniLogo)
    }
    
    lazy private var headerLabel: UILabel = .build { label in
        label.text = "NTBank"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .label
    }
    
    //MARK: - Initializer
    init() {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
    }
    
    convenience init(titleTextColor: UIColor) {
        self.init()
        headerLabel.textColor = titleTextColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: 111, height: 30)
    }
    
    //MARK: - Layout
    private func setupViews() {
        addSubviews(miniLogoImage, headerLabel)
        
        addConstraints()
    }
    
    private func addConstraints() {
        createLogoConstraints()
        createLabelConstraints()
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
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
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
