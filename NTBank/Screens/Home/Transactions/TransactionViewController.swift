//
//  TransactionViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 12/8/21.
//

import UIKit
import Combine

final class TransactionViewController: UIViewController {
    
    private var viewModel = TransactionViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    private var transactionInterface = TransactionInterfaceView()
    
    lazy var transactionDataSource = TransactionListDataSource(with: viewModel.transactions)

    override func viewDidLoad() {
        super.viewDidLoad()

        transactionInterface.transactionList.delegate = transactionDataSource
        transactionInterface.transactionList.dataSource = transactionDataSource
        
        bindViewModel()
    }
    
    override func loadView() {
        view = transactionInterface
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
    }
    
    private func bindViewModel() {
        viewModel.$transactions
            .sink { [weak self] transactions in
                self?.transactionDataSource.transactions = transactions
                self?.transactionInterface.transactionList.reloadData()
            }
            .store(in: &cancellables)
    }
}
