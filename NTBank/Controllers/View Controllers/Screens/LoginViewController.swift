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
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authDataResult, error in
            guard let self = self else { return }
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
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
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("LOG: \(error.localizedDescription)")
                return
            } else {
                let title = "Success!"
                let message = "Successfully sent a reset link."
                
                let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                
                let saveAction = UIAlertAction(title: "Ok", style: .default) { _ in return }
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in return }
                
                alertController.addAction(cancelAction)
                alertController.addAction(saveAction)
                
                DispatchQueue.main.async { self.present(alertController, animated: true) }
            }
        }
    }
}
