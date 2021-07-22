//
//  HomeViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/19/21.
//

import UIKit

class HomeViewController: UIViewController, HomeInterfaceViewDelegate, ActionCollectionViewControllerDelegate {
    
    var homeInterface = HomeInterfaceView()
    
    var actionController = ActionCollectionViewController()
    var transactionController = TransactionTableViewController()
    
    let userData: UserModelController
    
    // MARK: Initalizers
    
    init(with userData: UserModelController) {
        self.userData = userData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeInterface.homeDelegate = self
        actionController.actionDelegate = self
        userData.userDelegate = self
        
        updateCreditCard()
        updateTransactions()
    }
    
    override func loadView() {
        view = homeInterface
        title = tabBarItem.title
        view.backgroundColor = .systemBackground
        add(childVC: actionController, to: homeInterface.sendMoneyContainerView)
        add(childVC: transactionController, to: homeInterface.transactionContainerView)
    }

    func updateCreditCard() {
        homeInterface.creditCard.set(with: userData.user)
    }
    
    func updateTransactions() {
        transactionController.dataValues = userData.transactions
    }
}

//MARK: - User Delegate
extension HomeViewController: UserModelControllerDelegate {
    func didFetchUser(user: User) {
        updateCreditCard()
    }
    
    func didFetchTransactions(transactions: [Transaction]) {
        updateTransactions()
    }
}

//MARK: - Action Collection View Delegate
extension HomeViewController {
    func didSelectSendMoney() {
        //TODO: Show Send Money View
    }
    
    func didSelectPayBank() {
        let title = "Pay Bank"
        let message = "Please enter the amount you would like to send to the bank"
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alertController.addTextField()
        alertController.textFields![0].keyboardType = .numberPad

        let saveAction = UIAlertAction(title: "Send", style: .default) { action in
            guard let input = alertController.textFields![0].text else { return }
            print(input)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            return
        }

        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)

        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
    
    func didSelectPayLottery() {
        let title = "Pay Lottery"
        let message = "Please enter the amount you would like to pay the lottery"
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addTextField()
        alertController.textFields![0].keyboardType = .numberPad
        
        let saveAction = UIAlertAction(title: "Confirm", style: .default) { action in
            guard let input = alertController.textFields![0].text else { return }
            print(input)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            return
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
    
    func didSelectRecieveMoney() {
        let title = "Recieve Money"
        let message = "Please enter the amount you would like to recieve from the bank"
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addTextField()
        alertController.textFields![0].keyboardType = .numberPad
        
        let saveAction = UIAlertAction(title: "Confirm", style: .default) { action in
            guard let input = alertController.textFields![0].text else { return }
            print(input)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            return
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
}
