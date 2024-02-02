//
//  TransactionTableViewCell.swift
//  NTBank
//
//  Created by Javier Munoz on 6/21/21.
//

import UIKit

final class TransactionTableViewCell: UITableViewCell {
    
    private lazy var symbolImageView: NTSymbolView = .build()
    
    private lazy var titleLabel: UILabel = .build { label in
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .left
    }
    
    private lazy var subtitleLabel: UILabel = .build { label in
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .lightGray
    }
    
    private lazy var amountLabel: UILabel = .build { label in
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .label
        label.textAlignment = .right
    }
    
    //MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Set
    @MainActor
    func set(with transaction: Transaction) {
        titleLabel.text = transaction.title
        subtitleLabel.text = transaction.subtitle
        amountLabel.text = "$\(transaction.amount)"
        
        if transaction.amount < 0 {
            amountLabel.textColor = .systemRed
        } else {
            amountLabel.textColor = .label
        }
        
        let iconViewModel = IconViewModel(symbol: transaction.icon)
        symbolImageView.backgroundView.backgroundColor = iconViewModel.backgroundColor
        symbolImageView.symbolImageView.image = UIImage(systemName: iconViewModel.icon)
    }

    //MARK: - Layout
    private func setUpViews() {
        contentView.addSubviews(symbolImageView, titleLabel, subtitleLabel, amountLabel)
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        var constraints: [NSLayoutConstraint] = []
        
        constraints += createSymbolViewConstraints()
        constraints += createTitleLabelConstraints()
        constraints += createSubTitleLabelConstraints()
        constraints += createAmountLabelConstraints()
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func createSymbolViewConstraints() -> [NSLayoutConstraint] {
        let leading = symbolImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        let centerY = symbolImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        let width = symbolImageView.widthAnchor.constraint(equalToConstant: 40)
        let height = symbolImageView.heightAnchor.constraint(equalToConstant: 40)
        
        return [leading, centerY, width, height]
    }
    
    private func createTitleLabelConstraints() -> [NSLayoutConstraint] {
        let top = titleLabel.topAnchor.constraint(equalTo: symbolImageView.topAnchor)
        let leading = titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12)
        
        return [top, leading]
    }
    
    private func createSubTitleLabelConstraints() -> [NSLayoutConstraint] {
        let top = subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        let leading = subtitleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12)
        
        return [top, leading]
    }
    
    private func createAmountLabelConstraints() -> [NSLayoutConstraint] {
        let trailing = amountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        let centerY = amountLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        
        return [trailing, centerY]
    }
}

