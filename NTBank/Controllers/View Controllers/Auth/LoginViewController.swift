//
//  LoginViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/15/21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    var loginInterface = LoginInterfaceView()
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        createDismissKeyboardTapGesture()
        configureDidSelectLoginButton()
        configureDidSelectForgotPasswordButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func loadView() {
        view = loginInterface
        view.backgroundColor = .systemBackground
    }
    
    //MARK: - User Interaction
    func configureDidSelectLoginButton() {
        loginInterface.didSelectLoginButton = { [weak self] in
            guard let self = self else { return }
            guard let email = self.loginInterface.email, !email.isEmpty else {
                Alert.present(title: "Error", message: "Please enter your email.", from: self)
                return
            }
            
            guard let password = self.loginInterface.password, !password.isEmpty else {
                Alert.present(title: "Error", message: "Please enter your password.", from: self)
                return
            }
            
            self.showLoadingView()
            
            AuthService.shared.login(with: email, and: password) { [weak self] error in
                guard let self = self else { return }
                self.dismissLoadingView()
                if let error = error {
                    Alert.present(title: "Error", message: error.localizedDescription, from: self)
                } else {
                    let tabview = MainTabViewController()
                    tabview.modalPresentationStyle = .fullScreen
                    self.present(tabview, animated: true)
                }
            }
        }
    }
    
    func configureDidSelectForgotPasswordButton() {
        loginInterface.didSelectForgotPasswordButton = { [weak self] in
            guard let self = self else { return }
            Alert.presentForgotPasswordAlert(from: self) { email in
                guard let email = email, !email.isEmpty else { return }
                self.sendResetPasswordLink(with: email)
            }
        }
    }
    
    func sendResetPasswordLink(with email: String) {
        showLoadingView()
        Auth.auth().sendPasswordReset(withEmail: email) { [weak self] error in
            guard let self = self else { return }
            self.dismissLoadingView()
            if let error = error {
                Alert.present(title: "Error", message: error.localizedDescription, from: self)
                return
            } else {
                Alert.present(title: "Success!", message: "Successfully sent a reset link.", from: self)
            }
        }
    }
}
