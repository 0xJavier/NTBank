//
//  RankingTableViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/24/21.
//

import UIKit

class RankingTableViewController: UITableViewController {

    static let cellIdentifier = "RankingTableViewCell"
    
    var data = [User]()
    
    // MARK: Initializers
    
    init() {
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        setUpTableView()
    }

    func setUpTableView() {
        tableView.register(RankingTableViewCell.self, forCellReuseIdentifier: Self.cellIdentifier)
        tableView.showsVerticalScrollIndicator = false
    }
    
    // MARK: - Data Life Cycle
    
    func reloadData() {
        self.tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellIdentifier) as? RankingTableViewCell else {
            return RankingTableViewCell()
        }
        
        let dataValue = data[indexPath.row]
        
        cell.textLabel?.text = "\(indexPath.row + 1). \(dataValue.name)"
        cell.detailTextLabel?.text = "$\(dataValue.balance)"
        
        return cell
    }
}
