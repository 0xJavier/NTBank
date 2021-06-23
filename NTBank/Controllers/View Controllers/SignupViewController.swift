//
//  SignupViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/15/21.
//

import UIKit

class SignupViewController: SignupScreenViewController, SignupScreenViewControllerDelegate {
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signupDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //MARK: - SignupScreenViewControllerDelegate
    func didSelectCreateButton() {
        let tabview = MainTabViewController()
        UIApplication.shared.windows.first?.rootViewController = tabview
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}
