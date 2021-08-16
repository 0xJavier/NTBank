//
//  Alert.swift
//  NTBank
//
//  Created by Javier Munoz on 8/13/21.
//

import UIKit

struct Alert {
    static func present(title: String?, message: String, from controller: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(okAction)
        
        controller.present(alertController, animated: true, completion: nil)
    }
    
    static func presentForgotPasswordAlert(from controller: UIViewController, completion: @escaping(String?) -> Void) {
        let title = "Forgot Password?"
        let message = "Please enter your email to receive a reset link."
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addTextField()
        alertController.textFields![0].keyboardType = .emailAddress
        
        let saveAction = UIAlertAction(title: "Send", style: .default) { action in
            guard let email = alertController.textFields![0].text else { return }
            completion(email)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        controller.present(alertController, animated: true)
    }
    
    static func presentTextfieldIntAlert(with title: String, _ message: String, from controller: UIViewController, completion: @escaping(Int?) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addTextField()
        alertController.textFields![0].keyboardType = .emailAddress
        
        let saveAction = UIAlertAction(title: "Confirm", style: .default) { _ in
            guard let amount = alertController.textFields![0].text else { return }
            let amountAsInt = Int(amount)
            completion(amountAsInt)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        controller.present(alertController, animated: true)
    }
}
