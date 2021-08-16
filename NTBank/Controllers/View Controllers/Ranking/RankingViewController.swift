//
//  RankingViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/24/21.
//

import UIKit

class RankingViewController: UITableViewController {
    
    var players = [User]() {
        didSet { reloadData() }
    }
    
    //MARK: - Init
    
    init() {
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        getPlayers()
    }
    
    func setUpTableView() {
        tableView.register(RankingTableViewCell.self, forCellReuseIdentifier: CellTypes.rankingCell.rawValue)
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
    }
    
    func getPlayers() {
        GameService.shared.getAllPlayers { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let users):
                self.configureArray(with: users)
            case .failure(let error):
                Alert.present(title: "Error", message: error.localizedDescription, from: self)
            }
        }
    }
    
    func configureArray(with users: [User]) {
        players.removeAll()
        players = users
        players.sort { $0.balance > $1.balance }
    }
    
    func reloadData() {
        DispatchQueue.main.async { self.tableView.reloadData() }
    }
}

extension RankingViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellTypes.rankingCell.rawValue) as? RankingTableViewCell else {
            return RankingTableViewCell()
        }
        
        let player = players[indexPath.row]
        
        cell.textLabel?.text = "\(indexPath.row + 1). \(player.name)"
        cell.detailTextLabel?.text = "$\(player.balance)"
        
        return cell
    }
}
