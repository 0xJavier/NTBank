//
//  SettingsTableViewCell.swift
//  NTBank
//
//  Created by Javier Munoz on 8/4/21.
//

import UIKit

final class SettingsTableViewCell: UITableViewCell {
    private lazy var symbolImageView: NTSymbolView = .build()
    
    private lazy var titleLabel: UILabel = .build { label in
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .left
    }
    
    //MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @MainActor
    func set(with action: ImageAction) {
        titleLabel.text = action.title
        symbolImageView.backgroundView.backgroundColor = action.backgroundColor
        symbolImageView.symbolImageView.image = action.image
        
        accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        selectionStyle = .none
    }
    
    //MARK: - Layout
    private func setUpViews() {
        contentView.addSubviews(symbolImageView, titleLabel)
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        var constraints: [NSLayoutConstraint] = []
        
        constraints += createSymbolViewConstraints()
        constraints += createTitleLabelConstraints()
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func createSymbolViewConstraints() -> [NSLayoutConstraint] {
        let leading = symbolImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        let centerY = symbolImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        let width = symbolImageView.widthAnchor.constraint(equalToConstant: 30)
        let height = symbolImageView.heightAnchor.constraint(equalToConstant: 30)
        
        return [leading, centerY, width, height]
    }
    
    private func createTitleLabelConstraints() -> [NSLayoutConstraint] {
        let centerY = titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor)
        let leading = titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12)
        
        return [centerY, leading]
    }
}
