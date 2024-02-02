//
//  AuthCoordinator.swift
//  NTBank
//
//  Created by Javier Munoz on 2/2/24.
//

import UIKit

class AuthCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    weak var parentCoordinator: AppCoordinator?

    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let welcomeController = WelcomeViewController()
        welcomeController.coordinator = self
        navigationController.pushViewController(welcomeController, animated: true)
    }

    func loginTapped() {
        let loginController = LoginViewController()
        loginController.coordinator = self
        navigationController.pushViewController(loginController, animated: true)
    }

    func signupTapped() {
        let signupController = SignupViewController()
        signupController.coordinator = self
        navigationController.pushViewController(signupController, animated: true)
    }

    func userAuthenticated() {
        parentCoordinator?.didAuthenticate()
    }
}
