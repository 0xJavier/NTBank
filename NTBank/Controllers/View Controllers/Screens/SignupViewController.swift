//
//  SignupViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/15/21.
//

import UIKit
import Firebase

class SignupViewController: UIViewController, SignupInterfaceViewDelegate {
    
    var signupInterface = SignupInterfaceView()
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signupInterface.signupDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func loadView() {
        view = signupInterface
        view.backgroundColor = .systemBackground
    }
    
    //MARK: - SignupScreenViewControllerDelegate
    func didSelectCreateButton() {
        guard let name = signupInterface.nameTextfield.text else {
            print("LOG: Could not unwrap name")
            return
        }
        
        guard let email = signupInterface.emailTextfield.text else {
            print("LOG: Could not unwrap email")
            return
        }
        
        guard let cardColor = signupInterface.colorTextfield.text else {
            print("LOG: Could not unwrap Card Color")
            return
        }
        
        guard let password = signupInterface.passwordTextfield.text else {
            print("LOG: Could not unwrap password")
            return
        }
        
        guard let confirmPassword = signupInterface.confirmPasswordTextfield.text else {
            print("LOG: Could not unwrap confirm password")
            return
        }
        
        let data: [String:Any] = [
            "email": email.lowercased(),
            "name": name,
            "balance": 1500,
            "color": cardColor
        ]
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] dataResult, error in
            guard let self = self else { return }
            if let error = error {
                print("LOG: \(error.localizedDescription)")
                return
            } else {
                let batch = Firestore.firestore().batch()
                guard let userID = Auth.auth().currentUser?.uid else { return }
                let ref = Firestore.firestore().collection("players").document(userID)
                batch.setData(data, forDocument: ref)
                batch.commit { error in
                    if let error = error {
                        print("LOG: \(error.localizedDescription)")
                        return
                    } else {
                        let tabview = MainTabViewController()
                        tabview.modalPresentationStyle = .fullScreen
                        self.present(tabview, animated: true)
                    }
                }
            }
        }
    }
}
