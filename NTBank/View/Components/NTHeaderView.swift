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
        label.textColor = .white
        
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
        self.snp.makeConstraints { make in
            make.width.equalTo(111)
            make.height.equalTo(30)
        }
    }
    
    private func createLogoConstraints() {
        miniLogoImage.snp.makeConstraints { image in
            image.top.leading.bottom.equalToSuperview()
            image.width.equalTo(30)
        }
    }
    
    private func createLabelConstraints() {
        headerLabel.snp.makeConstraints { label in
            label.top.bottom.trailing.equalToSuperview()
            label.leading.equalTo(miniLogoImage.snp.trailing).inset(-10)
        }
    }
}
