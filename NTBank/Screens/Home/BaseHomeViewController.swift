//
//  BaseHomeViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 12/5/21.
//

import UIKit
import SnapKit

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
        cardVC.view.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(5)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(195)
        }
    }
    
    private func setupActionVC() {
        addChild(actionVC)
        view.addSubview(actionVC.view)
        actionVC.didMove(toParent: self)
        actionVC.view.snp.makeConstraints { make in
            make.top.equalTo(cardVC.view.snp.bottom).inset(-5)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(16)
            make.height.equalTo(130)
        }
    }
    
    private func setupTransactionVC() {
        addChild(transactionVC)
        view.addSubview(transactionVC.view)
        transactionVC.didMove(toParent: self)
        transactionVC.view.snp.makeConstraints { make in
            make.top.equalTo(actionVC.view.snp.bottom).inset(-5)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
