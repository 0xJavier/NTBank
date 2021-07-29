//
//  WelcomeViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/15/21.
//

import UIKit

class WelcomeViewController: UIViewController, WelcomeInterfaceViewDelegate {
    
    var welcomeInterface = WelcomeInterfaceView()
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeInterface.welcomeDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func loadView() {
        view = welcomeInterface
    }
        
    //MARK: - WelcomeInterfaceViewDelegate
    func didSelectLoginButton() {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    func didSelectSignupButton() {
        navigationController?.pushViewController(SignupViewController(), animated: true)
    }
}
