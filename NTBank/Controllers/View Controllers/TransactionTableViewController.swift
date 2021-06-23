//
//  TransactionTableViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/19/21.
//

import UIKit

class TransactionTableViewController: UITableViewController {
    
    static let cellIdentifier = "TransactionTableViewCell"
    
    var dataValues: [Transaction] = [] {
        didSet { reloadData() }
    }
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        setUpTableView()
    }

    func setUpTableView() {
        tableView.register(TransactionTableViewCell.self, forCellReuseIdentifier: Self.cellIdentifier)
        tableView.showsVerticalScrollIndicator = false
    }
    
    // MARK: - Data Life Cycle
    
    func reloadData() {
        self.tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataValues.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellIdentifier) as? TransactionTableViewCell else {
            return TransactionTableViewCell()
        }
        
        let data = dataValues[indexPath.row]

        cell.amountLabel.text = "$\(data.amount)"
        cell.titleLabel.text = data.action
        cell.subtitleLabel.text = "Subaction"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76.0
    }
}
