//
//  HomeViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/19/21.
//

import UIKit

class HomeViewController: UIViewController, HomeInterfaceViewDelegate {

    var homeInterface = HomeInterfaceView()
    
    var actionController = ActionCollectionViewController()
    var transactionController = TransactionTableViewController()
    
    let userData: UserMockData
    
    // MARK: Initalizers
    
    init(with userData: UserMockData) {
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateCreditCard()
        transactionController.dataValues = userData.transactions
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
}


