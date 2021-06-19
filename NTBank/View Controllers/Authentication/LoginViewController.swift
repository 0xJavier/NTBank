//
//  LoginViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/15/21.
//

import UIKit

class LoginViewController: LoginScreenViewController, LoginScreenViewControllerDelegate {
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        loginDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //MARK: - LoginScreenViewControllerDelegate
    func didSelectLoginButton() {
        let tabview = MainTabViewController()
        UIApplication.shared.windows.first?.rootViewController = tabview
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    func didSelectForgotPasswordButton() {
        
    }
}
