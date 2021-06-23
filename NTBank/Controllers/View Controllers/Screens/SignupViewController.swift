//
//  SignupViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/15/21.
//

import UIKit

class SignupViewController: UIViewController, SignupInterfaceViewDelegate {
    
    var signupInterface = SignupInterfaceView()
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signupInterface.signupDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func loadView() {
        view = signupInterface
        view.backgroundColor = .systemBackground
    }
    
    //MARK: - SignupScreenViewControllerDelegate
    func didSelectCreateButton() {
        let tabview = MainTabViewController()
        UIApplication.shared.windows.first?.rootViewController = tabview
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}
