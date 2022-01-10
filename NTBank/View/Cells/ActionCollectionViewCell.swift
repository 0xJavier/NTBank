//
//  ActionCollectionViewCell.swift
//  NTBank
//
//  Created by Javier Munoz on 6/19/21.
//

import UIKit

final class ActionCollectionViewCell: UICollectionViewCell {
    
    private let reuseID = "ActionCollectionViewCell"
    
    private lazy var background: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private lazy var symbolImageView: NTSymbolView = {
        let view = NTSymbolView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var cellTitle: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Josie Maran"
        
        return label
    }()
    
    //MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(with action: ImageAction) {
        cellTitle.text = action.title
        symbolImageView.set(with: action)
    }
    
    //MARK: - Layout
    private func setUpViews() {
        contentView.addSubviews(background)
        background.addSubviews(symbolImageView, cellTitle)
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        var constraints: [NSLayoutConstraint] = []
        
        constraints += createBackgroundConstraints()
        constraints += createSymbolViewConstraints()
        constraints += createLabelConstraints()
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func createBackgroundConstraints() -> [NSLayoutConstraint] {
        let leading = background.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        let top = background.topAnchor.constraint(equalTo: contentView.topAnchor)
        let trailing = background.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        let bottom = background.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)

        return [leading, top, trailing, bottom]
    }
    
    private func createSymbolViewConstraints() -> [NSLayoutConstraint] {
        let top = symbolImageView.topAnchor.constraint(equalTo: background.topAnchor, constant: 6)
        let centerX = symbolImageView.centerXAnchor.constraint(equalTo: background.centerXAnchor)
        let width = symbolImageView.widthAnchor.constraint(equalToConstant: 40)
        let height = symbolImageView.heightAnchor.constraint(equalToConstant: 40)

        return [top, centerX, width, height]
    }
    
    private func createLabelConstraints() -> [NSLayoutConstraint] {
        let top = cellTitle.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor)
        let leading = cellTitle.leadingAnchor.constraint(equalTo: background.leadingAnchor)
        let bottom = cellTitle.bottomAnchor.constraint(equalTo: background.bottomAnchor)
        let trailing = cellTitle.trailingAnchor.constraint(equalTo: background.trailingAnchor)

        return [top, leading, bottom, trailing]
    }
}
