//
//  SignupViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/15/21.
//

import UIKit

class SignupViewController: SignupScreenViewController, SignupScreenViewControllerDelegate {
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signupDelegate = self
    }
    
    //MARK: - SignupScreenViewControllerDelegate
    func didSelectCreateButton() {
        
    }
}
