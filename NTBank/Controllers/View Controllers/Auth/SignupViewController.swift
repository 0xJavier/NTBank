//
//  SignupViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/15/21.
//

import UIKit
import Firebase

class SignupViewController: UIViewController {
    
    var signupInterface = SignupInterfaceView()
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDidSelectCreateButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func loadView() {
        view = signupInterface
        view.backgroundColor = .systemBackground
    }
    
    //MARK: - User Interaction
    func configureDidSelectCreateButton() {
        signupInterface.didSelectCreateButton = { [weak self] in
            guard let self = self else { return }
            
            guard let name = self.signupInterface.name, !name.isEmpty else {
                Alert.presentSignupAlert(from: self)
                return
            }
            
            guard let email = self.signupInterface.email, !email.isEmpty else {
                Alert.presentSignupAlert(from: self)
                return
            }
            
            guard let cardColor = self.signupInterface.color else {
                Alert.presentSignupAlert(from: self)
                return
            }
            
            guard let password = self.signupInterface.password, !password.isEmpty, let confirm = self.signupInterface.confirmPassword, !confirm.isEmpty else {
                Alert.presentSignupAlert(from: self)
                return
            }
            
            if !(password == confirm) {
                Alert.present(title: "Error", message: "Please make sure your password matches.", from: self)
                return
            }
            
            self.showLoadingView()
            AuthService.shared.createUser(with: email, name, cardColor, and: password) { error in
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
}

extension Alert {
    static func presentSignupAlert(from controller: UIViewController) {
        let alertController = UIAlertController(title: "Error", message: "Please fill out all fields", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(okAction)
        
        controller.present(alertController, animated: true, completion: nil)
    }
}
