//
//  SettingsViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 8/4/21.
//

import UIKit
import Combine

final class SettingsViewController: UITableViewController {

    private var viewModel = SettingsViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
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
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Task.init { await viewModel.fetchUser() }
    }
    
    //MARK: -
    private func bindViewModel() {
        viewModel.$user
            .sink { [weak self] _ in self?.tableView.reloadData() }
            .store(in: &cancellables)
    }
    
    private func didSelectChangeCardColor() {
        Alert.presentChangeColor(from: self) { [weak self] color in
            guard let color = color else { return }
            self?.changeColor(with: color)
        }
    }
    
    private func changeColor(with color: CardColor) {
        Task.init {
            do {
                try await viewModel.changeCardColor(with: color)
                Alert.present(title: "Success!", message: "Successfully changed card color.", from: self)
            } catch {
                Alert.present(title: "Error", message: error.localizedDescription, from: self)
            }
        }
    }
}

//MARK: - Tableview
extension SettingsViewController {
    private func setUpTableView() {
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "Settings")
        tableView.register(AccountTableViewCell.self, forCellReuseIdentifier: "Account")
        tableView.showsVerticalScrollIndicator = false
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : viewModel.settings.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Account") as? AccountTableViewCell else {
                return AccountTableViewCell()
            }
            cell.set(with: viewModel.user)
            return cell
        }

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Settings") as? SettingsTableViewCell else {
            return SettingsTableViewCell()
        }
        let setting = viewModel.settings[indexPath.row]
        cell.set(with: setting)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 83 : 45
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                didSelectChangeCardColor()
            default:
                print("Could not get index")
            }
        }
    }
}
