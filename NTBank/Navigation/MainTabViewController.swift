//
//  MainTabViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/19/21.
//

import UIKit

class MainTabViewController: UITabBarController {
    
    let userData = UserMockData()
    let userDataReal = UserModelController()
    let playerModel = PlayerModelController()

    // MARK: - Initializers
    override func viewDidLoad() {
        viewControllers = [
            createNavController(viewController: HomeViewController(with: userDataReal), title: "Home", imageName: "house"),
            createNavController(viewController: LotteryViewController(), title: "Lottery", imageName: "dollarsign.square"),
            createNavController(viewController: RankingViewController(with: playerModel), title: "Ranking", imageName: "person.3")
        ]
    }
    
    private func createNavController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        viewController.title = title
        viewController.view.backgroundColor = .systemBackground
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = UIImage(systemName: imageName)
        navController.tabBarItem.selectedImage = UIImage(systemName: imageName + ".fill")
        return navController
    }
}
