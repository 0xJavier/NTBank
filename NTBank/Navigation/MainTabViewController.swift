//
//  MainTabViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/19/21.
//

import UIKit

class MainTabViewController: UITabBarController {
    
    override func viewDidLoad() {
        viewControllers = [
            createNavController(viewController: HomeViewController(), title: "Home", imageName: "house"),
            createNavController(viewController: LotteryViewController(), title: "Lottery", imageName: "dollarsign.square"),
            createNavController(viewController: RankingViewController(), title: "Ranking", imageName: "person.3"),
            createNavController(viewController: SettingsViewController(), title: "Settings", imageName: "gear", hasLargeTitle: true)
        ]
    }
    
    private func createNavController(viewController: UIViewController, title: String, imageName: String, hasLargeTitle: Bool = false) -> UIViewController {
        viewController.title = title
        //viewController.view.backgroundColor = .systemBackground
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = UIImage(systemName: imageName)
        navController.tabBarItem.selectedImage = UIImage(systemName: imageName + ".fill")
        navController.navigationBar.prefersLargeTitles = hasLargeTitle
        return navController
    }
}
