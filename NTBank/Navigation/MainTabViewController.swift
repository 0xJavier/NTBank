//
//  MainTabViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/19/21.
//

import UIKit

class MainTabViewController: UITabBarController {
    
    let userData = UserMockData()

    // MARK: - Initializers
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        setUpTabViewController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    func setUpTabViewController() {
        let viewControllers = [
            createHomeViewController(),
            createLotteryViewController(),
            createRankingViewController()
        ]
        
        self.viewControllers = viewControllers.map {
            UINavigationController(rootViewController: $0)
        }
    }

    private func createHomeViewController() -> UIViewController {
        let viewController = HomeViewController(with: userData)
        
        viewController.tabBarItem = UITabBarItem(title: "Home",
                                                 image: UIImage(systemName: "house"),
                                                 selectedImage: UIImage(systemName: "house.fill"))
        
        return viewController
    }
    
    private func createLotteryViewController() -> UIViewController {
        let viewController = LotteryViewController()
        
        viewController.tabBarItem = UITabBarItem(title: "Lottery",
                                                 image: UIImage(systemName: "dollarsign.square"),
                                                 selectedImage: UIImage(systemName: "dollarsign.square.fill"))
        
        return viewController
    }
    
    private func createRankingViewController() -> UIViewController {
        let viewController = RankingViewController(with: userData)
        
        viewController.tabBarItem = UITabBarItem(title: "Ranking",
                                                 image: UIImage(systemName: "person.3"),
                                                 selectedImage: UIImage(systemName: "person.3.fill"))
        
        return viewController
    }
}
