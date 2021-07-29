//
//  HomeViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/19/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: Interface
    var homeInterface = HomeInterfaceView()
    
    //MARK: Properties
    var user: User! {
        didSet { updateCreditCard() }
    }
    
    //MARK: ChildVCs
    let transactionController = TransactionTableViewController()
    let actionController = ActionCollectionViewController(collectionViewLayout: UICollectionViewLayout.init())
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        streamUserChanges()
    }
    
    override func loadView() {
        view = homeInterface
        
        add(childVC: transactionController, to: homeInterface.transactionContainerView)
        add(childVC: actionController, to: homeInterface.actionContainerView)
    }
    
    private func streamUserChanges() {
        NetworkManager.shared.streamUser { [weak self] user in
            guard let self = self else { return }
            if let user = user {
                self.user = user
            } else {
                print("COULD NOT STREAM USER")
            }
        }
    }
    
    private func updateCreditCard() {
        homeInterface.creditCard.set(with: user)
    }
}

