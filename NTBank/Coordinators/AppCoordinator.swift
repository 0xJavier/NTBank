//
//  AppCoordinator.swift
//  NTBank
//
//  Created by Javier Munoz on 2/2/24.
//

import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let service: AuthServiceProtocol
    
    init(with navigationController: UINavigationController, service: AuthServiceProtocol = AuthService()) {
        self.navigationController = navigationController
        self.service = service
    }

    func start() {
        if service.isUserLoggedIn {
            startHomeCoordinator()
        } else {
            startAuthCoordinator()
        }
    }

    func didAuthenticate() {
        childCoordinators.removeAll()
        startHomeCoordinator()
    }

    func didSignOut() {
        childCoordinators.removeAll()
        startAuthCoordinator()
    }

    func startAuthCoordinator() {
        let child = AuthCoordinator(with: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }

    func startHomeCoordinator() {
        let child = TabCoordinator(with: navigationController)
        navigationController.setNavigationBarHidden(true, animated: false)
        childCoordinators.append(child)
        child.start()
    }
}
