//
//  NTSymbolView.swift
//  NTBank
//
//  Created by Javier Munoz on 6/21/21.
//

import UIKit

final class NTSymbolView: UIView {
    
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
    
    func set(with action: ImageAction) {
        backgroundView.backgroundColor = action.backgroundColor
        symbolImageView.image = action.image
    }
    
    private func setUpViews() {
        addSubviews(backgroundView)
        backgroundView.addSubview(symbolImageView)
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        createBackgroundConstraints()
        createSymbolConstraints ()
    }
    
    private func createBackgroundConstraints() {
        backgroundView.snp.makeConstraints { view in
            view.edges.equalToSuperview()
        }
    }
    
    private func createSymbolConstraints() {
        symbolImageView.snp.makeConstraints { imageView in
            imageView.center.equalTo(backgroundView.snp.center)
            imageView.width.height.equalTo(20)
        }
    }
}
