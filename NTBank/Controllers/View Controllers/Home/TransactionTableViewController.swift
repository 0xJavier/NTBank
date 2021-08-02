//
//  TransactionTableViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/19/21.
//

import UIKit

class TransactionTableViewController: UITableViewController {
    
    //MARK: Properties
    var transactions = [Transaction]() {
        didSet {
            transactionDataSource.transactions = transactions
            reloadData()
        }
    }
    
    lazy var transactionDataSource = TransactionListDataSource(with: transactions)
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        setUpTableView()
        streamTransactions()
    }

    func setUpTableView() {
        tableView.register(TransactionTableViewCell.self, forCellReuseIdentifier: CellTypes.transactionCell.rawValue)
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        tableView.delegate = transactionDataSource
        tableView.dataSource = transactionDataSource
    }
    
    // MARK: - Data Life Cycle
    func reloadData() {
        DispatchQueue.main.async { self.tableView.reloadData() }
    }
    
    //MARK: -
    func streamTransactions() {
        NetworkManager.shared.streamUserTransactions { [weak self] transactions in
            guard let self = self else { return }
            if let transactions = transactions {
                self.transactions.removeAll()
                self.transactions = transactions
            } else {
                print("COULD NOT STREAM Transactions")
            }
        }
    }
}
