//
//  WelcomeViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/15/21.
//

import UIKit
import SwiftUI

class WelcomeViewController: WelcomeScreenViewController, WelcomeScreenViewControllerDelegate {
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
        
    //MARK: - WelcomeScreenViewControllerDelegate
    func didSelectLoginButton() {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    func didSelectSignupButton() {
        navigationController?.pushViewController(SignupViewController(), animated: true)
    }
}
