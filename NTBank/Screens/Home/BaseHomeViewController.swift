//
//  BaseHomeViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 12/5/21.
//

import UIKit

final class BaseHomeViewController: UIViewController {
    
    private var cardVC = CreditCardViewController()
    private var actionVC = ActionViewController()
    private var transactionVC = TransactionViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupCreditCardVC()
        setupActionVC()
        setupTransactionVC()
    }
}

extension BaseHomeViewController {
    private func setupCreditCardVC() {
        addChild(cardVC)
        view.addSubview(cardVC.view)
        cardVC.didMove(toParent: self)
        NSLayoutConstraint.activate([
            cardVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            cardVC.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            cardVC.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            cardVC.view.heightAnchor.constraint(equalToConstant: 195)
        ])
    }
    
    private func setupActionVC() {
        addChild(actionVC)
        view.addSubview(actionVC.view)
        actionVC.didMove(toParent: self)
        NSLayoutConstraint.activate([
            actionVC.view.topAnchor.constraint(equalTo: cardVC.view.bottomAnchor, constant: 5),
            actionVC.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            actionVC.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            actionVC.view.heightAnchor.constraint(equalToConstant: 130)
        ])
    }
    
    private func setupTransactionVC() {
        addChild(transactionVC)
        view.addSubview(transactionVC.view)
        transactionVC.didMove(toParent: self)
        NSLayoutConstraint.activate([
            transactionVC.view.topAnchor.constraint(equalTo: actionVC.view.bottomAnchor, constant: 5),
            transactionVC.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            transactionVC.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            transactionVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
