//
//  WelcomeViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/15/21.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    var welcomeInterface = WelcomeInterfaceView()
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeInterface.didSelectLoginButton = { [weak self] in
            self?.navigationController?.pushViewController(LoginViewController(), animated: true)
        }
        
        welcomeInterface.didSelectSignupButton = { [weak self] in
            self?.navigationController?.pushViewController(SignupViewController(), animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func loadView() {
        view = welcomeInterface
    }
}
