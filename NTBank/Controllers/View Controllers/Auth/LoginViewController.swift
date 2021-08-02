//
//  LoginViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/15/21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, LoginInterfaceViewDelegate {
    
    var loginInterface = LoginInterfaceView()
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        createDismissKeyboardTapGesture()
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
        guard let email = loginInterface.emailTextfield.text else {
            print("LOG: Could not unwrap email text string")
            return
        }
        
        guard let password = loginInterface.passwordTextfield.text else {
            print("LOG: Could not unwrap password text string")
            return
        }
        
        showLoadingView()
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authDataResult, error in
            guard let self = self else { return }
            self.dismissLoadingView()
            if let error = error {
                self.presentSimpleAlert(title: "Error", message: error.localizedDescription)
            } else {
                let tabview = MainTabViewController()
                tabview.modalPresentationStyle = .fullScreen
                self.present(tabview, animated: true)
            }
        }
    }
    
    func didSelectForgotPasswordButton() {
        let title = "Forgot Password?"
        let message = "Please enter your email to recieve a reset link."
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addTextField()
        alertController.textFields![0].keyboardType = .emailAddress
        
        let saveAction = UIAlertAction(title: "Send", style: .default) { action in
            guard let email = alertController.textFields![0].text else { return }
            self.sendResetPasswordLink(with: email)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            return
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
    
    func sendResetPasswordLink(with email: String) {
        showLoadingView()
        Auth.auth().sendPasswordReset(withEmail: email) { [weak self] error in
            guard let self = self else { return }
            self.dismissLoadingView()
            if let error = error {
                self.presentSimpleAlert(title: "Error", message: error.localizedDescription)
                return
            } else {
                self.presentSimpleAlert(title: "Success!", message: "Successfully sent a reset link.")
            }
        }
    }
}
