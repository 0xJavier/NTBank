//
//  Alert.swift
//  NTBank
//
//  Created by Javier Munoz on 8/13/21.
//

import UIKit

extension UIViewController {
    struct Alert {
        static func present(title: String?, message: String, from controller: UIViewController) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

            let okAction = UIAlertAction(title: "OK", style: .default)
            
            alertController.addAction(okAction)
            
            controller.present(alertController, animated: true, completion: nil)
        }
        
        static func presentCollectLotteryAlert(from controller: UIViewController, completion: @escaping() -> Void) {
            let title = "Collect Lottery"
            let message = "Are you sure you want to collect the lottery"
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let collectAction = UIAlertAction(title: "Collect", style: .default) { _ in
                completion()
            }

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

            alertController.addAction(cancelAction)
            alertController.addAction(collectAction)
            
            controller.present(alertController, animated: true, completion: nil)
        }
        
        static func presentCollect200Alert(from controller: UIViewController, completion: @escaping() -> Void) {
            let title = "Collect $200"
            let message = "Would you like to collect $200?"
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let collectAction = UIAlertAction(title: "Yes", style: .default) { _ in
                completion()
            }

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

            alertController.addAction(cancelAction)
            alertController.addAction(collectAction)
            
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
            alertController.textFields![0].keyboardType = .numberPad
            
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
        
        static func presentChangeColor(from controller: UIViewController, completion: @escaping(CardColor?) -> Void) {
            let sheet = UIAlertController(title: "Change Card Color", message: "Choose new card color.", preferredStyle: .actionSheet)
            
            for color in CardColor.allCases {
                let option = UIAlertAction(title: color.rawValue, style: .default) { _ in
                    completion(color)
                }
                sheet.addAction(option)
            }
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            sheet.addAction(cancel)
            
            controller.present(sheet, animated: true, completion: nil)
        }
    }
}


