//
//  NTCreditCard.swift
//  NTBank
//
//  Created by Javier Munoz on 6/19/21.
//

import UIKit

class NTCreditCard: UIView {

    lazy private var background: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.systemBlue.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 10
        
        return view
    }()
    
    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Balance:"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        
        return label
    }()
    
    lazy private var amountLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    lazy private var nameLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Player"
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        label.textColor = .white
        
        return label
    }()
        
    //MARK: - Init
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setUpViews()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(with user: User) {
        DispatchQueue.main.async { [self] in
            self.amountLabel.text = "$\(user.balance)"
            self.nameLabel.text = user.name
            self.background.backgroundColor = user.colorLiteral
            self.background.layer.shadowColor = user.colorLiteral.cgColor
        }
    }

    //MARK: - Setup
    private func setUpViews() {
        addSubviews(background, titleLabel, amountLabel, nameLabel)
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        var constraints: [NSLayoutConstraint] = []
        
        constraints += createCardConstraints()
        constraints += createBackgroundConstraints()
        constraints += createAmountConstraints()
        constraints += createTitleConstraints()
        constraints += createNameConstraints()
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func createCardConstraints() -> [NSLayoutConstraint] {
        return [
            widthAnchor.constraint(equalToConstant: 343),
            heightAnchor.constraint(equalToConstant: 192)
        ]
    }
    
    private func createBackgroundConstraints() -> [NSLayoutConstraint] {
        let top = background.topAnchor.constraint(equalTo: topAnchor)
        let leading = background.leadingAnchor.constraint(equalTo: leadingAnchor)
        let bottom = background.bottomAnchor.constraint(equalTo: bottomAnchor)
        let trailing = background.trailingAnchor.constraint(equalTo: trailingAnchor)
        
        return [top, leading, bottom, trailing]
    }
    
    private func createAmountConstraints() -> [NSLayoutConstraint] {
        let leading = amountLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        let bottom = amountLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24)
        
        return [leading, bottom]
    }
    
    private func createTitleConstraints() -> [NSLayoutConstraint] {
        let leading = titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        let bottom = titleLabel.bottomAnchor.constraint(equalTo: amountLabel.topAnchor, constant: -4)
        
        return [leading, bottom]
    }
    
    private func createNameConstraints() -> [NSLayoutConstraint] {
        let bottom = nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24)
        let trailing = nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        
        return [bottom, trailing]
    }
}
