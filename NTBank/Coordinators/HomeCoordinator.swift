//
//  HomeCoordinator.swift
//  NTBank
//
//  Created by Javier Munoz on 2/2/24.
//

import UIKit

class HomeCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeController = BaseHomeViewController()
        homeController.title = "Home"
        homeController.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: SFSymbols.house.rawValue+".fill"),
            tag: 0
        )
        navigationController.pushViewController(homeController, animated: false)
    }
}
