//
//  AccountTableViewCell.swift
//  NTBank
//
//  Created by Javier Munoz on 8/4/21.
//

import UIKit

final class AccountTableViewCell: UITableViewCell {
    private lazy var background: UIView = .build { view in
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 62 / 2
    }
    
    private lazy var symbolImageView: UIImageView = .build { view in
        let boldFont = UIFont.boldSystemFont(ofSize: 24)
        let configuration = UIImage.SymbolConfiguration(font: boldFont)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: SFSymbols.person.rawValue, withConfiguration: configuration)
        view.tintColor = .white
    }
    
    private lazy var titleLabel: UILabel = .build { label in
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .left
    }
    
    private lazy var subtitleLabel: UILabel = .build { label in
        label.font = UIFont.systemFont(ofSize: 17)
    }
    
    private lazy var stackview: UIStackView = .build { view in
        view.axis = .vertical
        view.distribution = .fillEqually
    }
    
    //MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(with user: User) {
        background.backgroundColor = user.color.uiColor
        titleLabel.text = user.name
        subtitleLabel.text = user.email
    }

    //MARK: - Layout
    private func setUpViews() {
        contentView.addSubviews(background, stackview)
        background.addSubview(symbolImageView)
        stackview.addArrangedSubviews(titleLabel, subtitleLabel)
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        var constraints: [NSLayoutConstraint] = []
        
        constraints += createBackgroundConstraints()
        constraints += createImageConstraints()
        constraints += createStackviewConstraints()
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func createBackgroundConstraints() -> [NSLayoutConstraint] {
        let leading = background.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        let centerY = background.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        let width = background.widthAnchor.constraint(equalToConstant: 62)
        let height = background.heightAnchor.constraint(equalToConstant: 62)
        
        return [leading, centerY, width, height]
    }
    
    private func createImageConstraints() -> [NSLayoutConstraint] {
        let centerY = symbolImageView.centerYAnchor.constraint(equalTo: background.centerYAnchor)
        let centerX = symbolImageView.centerXAnchor.constraint(equalTo: background.centerXAnchor)
        
        return [centerY, centerX]
    }
    
    private func createStackviewConstraints() -> [NSLayoutConstraint] {
        let top = stackview.topAnchor.constraint(equalTo: background.topAnchor)
        let leading = stackview.leadingAnchor.constraint(equalTo: background.trailingAnchor, constant: 12)
        let bottom = stackview.bottomAnchor.constraint(equalTo: background.bottomAnchor)
        let width = stackview.widthAnchor.constraint(equalToConstant: 200)
        
        return [top, leading, bottom, width]
    }
}
