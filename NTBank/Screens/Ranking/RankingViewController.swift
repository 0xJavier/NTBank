//
//  RankingViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/24/21.
//

import UIKit
import Combine

final class RankingViewController: UITableViewController {
    
    private var viewModel = RankingViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    lazy private var rankingDataSource = RankingDataSource(with: viewModel.playersList)
    
    //MARK: - Initializer
    init() {
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Task.init { await viewModel.fetchPlayers() }
    }
    
    //MARK: -
    
    private func bindViewModel() {
        viewModel.$playersList
            .sink { [weak self] users in
                guard let self = self else { return }
                self.rankingDataSource.users = users
                self.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    private func setUpTableView() {
        tableView.register(RankingTableViewCell.self, forCellReuseIdentifier: CellTypes.rankingCell.rawValue)
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        tableView.dataSource = rankingDataSource
    }
}
