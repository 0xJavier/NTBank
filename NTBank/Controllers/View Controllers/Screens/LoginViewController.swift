//
//  LoginViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/15/21.
//

import UIKit

class LoginViewController: UIViewController, LoginInterfaceViewDelegate {
    
    var loginInterface = LoginInterfaceView()
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        loginInterface.loginDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func loadView() {
        view = loginInterface
        view.backgroundColor = .systemBackground
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
