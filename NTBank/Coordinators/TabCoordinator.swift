//
//  TabCoordinator.swift
//  NTBank
//
//  Created by Javier Munoz on 2/2/24.
//

import UIKit

class TabCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    let tabBarController = UITabBarController()
    
    let homeCoordinator = HomeCoordinator(with: UINavigationController())
    let lotteryCoordinator = LotteryCoordinator(with: UINavigationController())
    let rankingCoordinator = RankingCoordinator(with: UINavigationController())
    let settingsCoordinator = SettingsCoordinator(with: UINavigationController())

    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        homeCoordinator.start()
        lotteryCoordinator.start()
        rankingCoordinator.start()
        settingsCoordinator.start()
        
        tabBarController.setViewControllers([
            homeCoordinator.navigationController,
            lotteryCoordinator.navigationController,
            rankingCoordinator.navigationController,
            settingsCoordinator.navigationController,
        ], animated: false)
        
        navigationController.viewControllers = [tabBarController]
    }
}
