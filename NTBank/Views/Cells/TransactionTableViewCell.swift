//
//  TransactionTableViewCell.swift
//  NTBank
//
//  Created by Javier Munoz on 6/21/21.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    
    var symbolImageView: NTSymbolView = {
        let view = NTSymbolView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .left
        
        return label
    }()
    
    var subtitleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .lightGray
        
        return label
    }()
    
    var amountLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .label
        label.textAlignment = .right
        
        return label
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Set
    func set(with transaction: Transaction) {
        titleLabel.text = transaction.action
        subtitleLabel.text = "Subaction"
        amountLabel.text = "$\(transaction.amount)"
    }

    //MARK: - Setup
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

