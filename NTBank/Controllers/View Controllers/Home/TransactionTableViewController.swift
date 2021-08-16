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
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    // MARK: - Data Life Cycle
    func reloadData() {
        DispatchQueue.main.async { self.tableView.reloadData() }
    }
    
    //MARK: -
    func streamTransactions() {
        UserService.shared.streamUserTransactions { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let transactions):
                self.transactions.removeAll()
                self.transactions = transactions
            case .failure(let error):
                Alert.present(title: "Error", message: error.localizedDescription, from: self)
            }
        }
    }
}
