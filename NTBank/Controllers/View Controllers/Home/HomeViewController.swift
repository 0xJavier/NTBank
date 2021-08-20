//
//  HomeViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/19/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    var homeInterface = HomeInterfaceView()
    
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
        
        view.backgroundColor = .systemBackground
        add(childVC: transactionController, to: homeInterface.transactionContainerView)
        add(childVC: actionController, to: homeInterface.actionContainerView)
    }
    
    //MARK: - User + UI
    private func streamUserChanges() {
        UserService.shared.streamUser { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                self.user = user
            case .failure(let error):
                Alert.present(title: "Error", message: error.localizedDescription, from: self)
            }
        }
    }
    
    private func updateCreditCard() {
        homeInterface.creditCard.set(with: user)
    }
}

