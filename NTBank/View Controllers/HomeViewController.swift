//
//  HomeViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/19/21.
//

import UIKit

class HomeViewController: HomeScreenViewController, HomeScreenViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = tabBarItem.title
        view.backgroundColor = .systemBackground
        
        homeDelegate = self
    }

}


