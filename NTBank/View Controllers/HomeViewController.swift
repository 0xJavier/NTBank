//
//  HomeViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/19/21.
//

import UIKit

class HomeViewController: HomeScreenViewController, HomeScreenViewControllerDelegate {

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

        title = tabBarItem.title
        view.backgroundColor = .systemBackground
        
        homeDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateCreditCard()
        transactionChildViewController.dataValues = userData.transactions
    }

    func updateCreditCard() {
        creditCard.set(with: userData.user)
    }
}


