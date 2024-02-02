//
//  SettingsCoordinator.swift
//  NTBank
//
//  Created by Javier Munoz on 2/2/24.
//

import UIKit

class SettingsCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let settingsController = SettingsViewController()
        settingsController.title = "Settings"
        settingsController.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: SFSymbols.gear.rawValue),
            tag: 3
        )
        navigationController.pushViewController(settingsController, animated: false)
    }
}
