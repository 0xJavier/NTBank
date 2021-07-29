//
//  HomeInterfaceView.swift
//  NTBank
//
//  Created by Javier Munoz on 6/19/21.
//

import UIKit

class HomeInterfaceView: UIView {
    
    lazy var creditCard = NTCreditCard()
    
    lazy var quickActionLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Quick Actions"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        
        return label
    }()
    
    lazy var actionContainerView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var transactionLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Latest Transactions"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        
        return label
    }()
    
    lazy var transactionContainerView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // MARK: Initalizers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpViews()
    }
    
    private func setUpViews() {
        addSubviews(creditCard, quickActionLabel, actionContainerView,
                         transactionLabel, transactionContainerView)
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        var constraints: [NSLayoutConstraint] = []
        
        constraints += createCreditCardConstraints()
        constraints += createSendMoneyLabelConstraints()
        constraints += createSendMoneyContainerViewConstraints()
        constraints += createTransactionLabelConstraints()
        constraints += createTransactionContainerViewConstraints()
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func createCreditCardConstraints() -> [NSLayoutConstraint] {
        return [
            creditCard.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            creditCard.centerXAnchor.constraint(equalTo: centerXAnchor)
        ]
    }
    
    private func createSendMoneyLabelConstraints() -> [NSLayoutConstraint] {
        let top = quickActionLabel.topAnchor.constraint(equalTo: creditCard.bottomAnchor)
        let leading = quickActionLabel.leadingAnchor.constraint(equalTo: creditCard.leadingAnchor)
        let height = quickActionLabel.heightAnchor.constraint(equalToConstant: 54)
        
        return [top, leading, height]
    }
    
    private func createSendMoneyContainerViewConstraints() -> [NSLayoutConstraint] {
        let top = actionContainerView.topAnchor.constraint(equalTo: quickActionLabel.bottomAnchor)
        let leading = actionContainerView.leadingAnchor.constraint(equalTo: creditCard.leadingAnchor)
        let trailing = actionContainerView.trailingAnchor.constraint(equalTo: creditCard.trailingAnchor)
        let height = actionContainerView.heightAnchor.constraint(equalToConstant: 105)
        
        return [top, leading, trailing, height]
    }
    
    private func createTransactionLabelConstraints() -> [NSLayoutConstraint] {
        let top = transactionLabel.topAnchor.constraint(equalTo: actionContainerView.bottomAnchor)
        let leading = transactionLabel.leadingAnchor.constraint(equalTo: creditCard.leadingAnchor)
        let height = transactionLabel.heightAnchor.constraint(equalToConstant: 54)
        
        return [top, leading, height]
    }
    
    private func createTransactionContainerViewConstraints() -> [NSLayoutConstraint] {
        let top = transactionContainerView.topAnchor.constraint(equalTo: transactionLabel.bottomAnchor)
        let leading = transactionContainerView.leadingAnchor.constraint(equalTo: leadingAnchor)
        let trailing = transactionContainerView.trailingAnchor.constraint(equalTo: creditCard.trailingAnchor)
        let bottom = transactionContainerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 16)
        
        return [top, leading, trailing, bottom]
    }
    
    //MARK: - Selectors
}
