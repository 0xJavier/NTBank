//
//  HomeScreenViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/19/21.
//

import UIKit
import SwiftUI

protocol HomeScreenViewControllerDelegate: HomeScreenViewController {}

private extension CGFloat {}

class HomeScreenViewController: UIViewController {
    
    lazy var creditCard = NTCreditCard()
    
    lazy var sendMoneyLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Send Money"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        
        return label
    }()
    
    lazy var sendMoneyContainerView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var transactionLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Transactions"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        
        return label
    }()
    
    lazy var transactionContainerView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    weak var homeDelegate: HomeScreenViewControllerDelegate?
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
    }
    
    private func setUpViews() {
        view.addSubviews(creditCard, sendMoneyLabel, sendMoneyContainerView,
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
            creditCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            creditCard.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
    }
    
    private func createSendMoneyLabelConstraints() -> [NSLayoutConstraint] {
        let top = sendMoneyLabel.topAnchor.constraint(equalTo: creditCard.bottomAnchor)
        let leading = sendMoneyLabel.leadingAnchor.constraint(equalTo: creditCard.leadingAnchor)
        let height = sendMoneyLabel.heightAnchor.constraint(equalToConstant: 54)
        
        return [top, leading, height]
    }
    
    private func createSendMoneyContainerViewConstraints() -> [NSLayoutConstraint] {
        let top = sendMoneyContainerView.topAnchor.constraint(equalTo: sendMoneyLabel.bottomAnchor)
        let leading = sendMoneyContainerView.leadingAnchor.constraint(equalTo: creditCard.leadingAnchor)
        let trailing = sendMoneyContainerView.trailingAnchor.constraint(equalTo: creditCard.trailingAnchor)
        let height = sendMoneyContainerView.heightAnchor.constraint(equalToConstant: 83)
        
        return [top, leading, trailing, height]
    }
    
    private func createTransactionLabelConstraints() -> [NSLayoutConstraint] {
        let top = transactionLabel.topAnchor.constraint(equalTo: sendMoneyContainerView.bottomAnchor)
        let leading = transactionLabel.leadingAnchor.constraint(equalTo: creditCard.leadingAnchor)
        let height = transactionLabel.heightAnchor.constraint(equalToConstant: 54)
        
        return [top, leading, height]
    }
    
    private func createTransactionContainerViewConstraints() -> [NSLayoutConstraint] {
        let top = transactionContainerView.topAnchor.constraint(equalTo: transactionLabel.bottomAnchor)
        let leading = transactionContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailing = transactionContainerView.trailingAnchor.constraint(equalTo: creditCard.trailingAnchor)
        let bottom = transactionContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 16)
        
        return [top, leading, trailing, bottom]
    }
    
    //MARK: - Selectors
}

struct HomeScreenViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            HomeScreenViewController()
        }
    }
}
