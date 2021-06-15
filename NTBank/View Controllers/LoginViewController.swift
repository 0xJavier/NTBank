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
    
    //MARK: - LoginScreenViewControllerDelegate
    func didSelectLoginButton() {
        
    }
    
    func didSelectForgotPasswordButton() {
        
    }
}
