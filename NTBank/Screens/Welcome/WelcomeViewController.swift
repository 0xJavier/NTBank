//
//  WelcomeViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/15/21.
//

import UIKit

final class WelcomeViewController: UIViewController, WelcomeInterfaceViewDelegate {
    
    private var welcomeInterface = WelcomeInterfaceView()
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeInterface.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func loadView() {
        view = welcomeInterface
    }
    
    //MARK: -
    
    func didSelectLoginButton() {
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    func didSelectSignupButton() {
        self.navigationController?.pushViewController(SignupViewController(), animated: true)
    }
}
