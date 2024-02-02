//
//  LotteryCoordinator.swift
//  NTBank
//
//  Created by Javier Munoz on 2/2/24.
//

import UIKit

class LotteryCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let lotteryController = LotteryViewController()
        lotteryController.title = "Lottery"
        lotteryController.tabBarItem = UITabBarItem(
            title: "Lottery",
            image: UIImage(systemName: SFSymbols.dollarSignSquare.rawValue),
            tag: 1
        )
        navigationController.pushViewController(lotteryController, animated: false)
    }
}
