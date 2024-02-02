//
//  RankingCoordinator.swift
//  NTBank
//
//  Created by Javier Munoz on 2/2/24.
//

import UIKit

class RankingCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let rankingController = RankingViewController()
        rankingController.title = "Ranking"
        rankingController.tabBarItem = UITabBarItem(
            title: "Ranking",
            image: UIImage(systemName: SFSymbols.person.rawValue),
            tag: 2
        )
        navigationController.pushViewController(rankingController, animated: false)
    }
}
