//
//  RankingViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/24/21.
//

import UIKit

class RankingViewController: RankingTableViewController, PlayerModelControllerDelegate {
    
    let playerModel: PlayerModelController
    
    // MARK: Initalizers
    
    init(with playerModel: PlayerModelController) {
        self.playerModel = playerModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = tabBarItem.title
        playerModel.playerDelegate = self
        data = playerModel.players
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        playerModel.retrievePlayers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        data = playerModel.players
        reloadTableview()
    }
    
    func didFetchPlayers(players: [User]) {
        data = players
        reloadTableview()
    }
    
    func reloadTableview() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
