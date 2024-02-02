//
//  NTCreditCard.swift
//  NTBank
//
//  Created by Javier Munoz on 6/19/21.
//

import UIKit

final class NTCreditCard: UIView {

    lazy private var background: UIView = .build { view in
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 10
    }
    
    lazy private var headerView = NTHeaderView(titleTextColor: .white)
    
    lazy private var titleLabel: UILabel = .build { label in
        label.text = "Balance:"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
    }
    
    lazy private var amountLabel: UILabel = .build { label in
        label.text = "$"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .white
    }
    
    lazy private var nameLabel: UILabel = .build { label in
        label.text = "Player"
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        label.textColor = .white
    }
        
    //MARK: - Initializer
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setUpViews()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(with user: User) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.amountLabel.text = "$\(user.balance)"
            self.nameLabel.text = user.name
            self.background.backgroundColor = user.color.uiColor
        }
    }

    //MARK: - Layout
    private func setUpViews() {
        addSubviews(background, headerView, titleLabel, amountLabel, nameLabel)
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        createCardConstraints()
        createBackgroundConstraints()
        createHeaderConstraints()
        createAmountConstraints()
        createTitleConstraints()
        createNameConstraints()
    }
    
    private func createCardConstraints() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 343),
            heightAnchor.constraint(equalToConstant: 192),
        ])
    }
    
    private func createBackgroundConstraints() {
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: topAnchor),
            background.leadingAnchor.constraint(equalTo: leadingAnchor),
            background.bottomAnchor.constraint(equalTo: bottomAnchor),
            background.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func createHeaderConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
    }
    
    private func createAmountConstraints() {
        NSLayoutConstraint.activate([
            amountLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            amountLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
        ])
    }
    
    private func createTitleConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: amountLabel.topAnchor)
        ])
    }
    
    private func createNameConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}

#if DEBUG
import SwiftUI

struct NTCreditCard_Previews: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            NTCreditCard()
        }
    }
}
#endif
