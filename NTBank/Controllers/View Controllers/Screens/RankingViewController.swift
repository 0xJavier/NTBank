//
//  RankingViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/24/21.
//

import UIKit

class RankingViewController: RankingTableViewController {
        
    let userData: UserMockData
    
    // MARK: Initalizers
    
    init(with userData: UserMockData) {
        self.userData = userData
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = userData.players
        title = tabBarItem.title
    }
}
