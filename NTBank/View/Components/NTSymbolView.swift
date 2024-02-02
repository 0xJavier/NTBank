//
//  NTSymbolView.swift
//  NTBank
//
//  Created by Javier Munoz on 6/21/21.
//

import UIKit

final class NTSymbolView: UIView {
    
    lazy var backgroundView: UIView = .build { view in
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 10
    }
    
    lazy var symbolImageView: UIImageView = .build { view in
        view.image = UIImage(systemName: SFSymbols.person.rawValue)
        view.tintColor = .white
    }
    
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
        createSymbolConstraints()
    }
    
    private func createBackgroundConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    private func createSymbolConstraints() {
        NSLayoutConstraint.activate([
            symbolImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            symbolImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}

#if DEBUG
import SwiftUI

struct NTSymbolView_Previews: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            NTSymbolView()
        }
    }
}
#endif
