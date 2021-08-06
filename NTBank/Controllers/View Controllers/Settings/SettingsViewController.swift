//
//  SettingsViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 8/4/21.
//

import UIKit

class SettingsViewController: UITableViewController {

    var settings: [Setting] = [
        //Setting(title: "Change Name", image: UIImage(systemName: "person.fill")!, color: .systemOrange),
        Setting(title: "Change Card Color", image: UIImage(systemName: "creditcard.fill")!, color: .systemBlue),
        //Setting(title: "Reset Game", image: UIImage(systemName: "arrow.clockwise")!, color: .systemGreen)
    ]
    
    var newCardColor: String?
    
    var user = User(id: "12345", userInfo: ["name": "Player", "email": "player@NTBank.com", "color": "red", "balance": 1500]) {
        didSet { tableView.reloadData() }
    }
    
    init() {
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getUser()
    }
    
    func setUpTableView() {
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "Settings")
        tableView.register(AccountTableViewCell.self, forCellReuseIdentifier: "Account")
        tableView.showsVerticalScrollIndicator = false
    }
    
    func getUser() {
        NetworkManager.shared.streamUser { user in
            guard let user = user else { return }
            self.user = user
        }
    }
    
    func didSelectChangeCardColor() {
        let sheet = UIAlertController(title: "Change Card Color", message: "Choose new card color.", preferredStyle: .actionSheet)
        
        for color in CardColor.allCases {
            let option = UIAlertAction(title: color.rawValue, style: .default) { [weak self] _ in
                guard let self = self else { return }
                self.newCardColor = color.rawValue
                self.changeColor()
            }
            sheet.addAction(option)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        sheet.addAction(cancel)
        
        self.present(sheet, animated: true, completion: nil)
    }
    
    func changeColor() {
        guard let cardColor = newCardColor else { return }
        showLoadingView()
        NetworkManager.shared.changeUserCardColor(with: cardColor) { [weak self] bool in
            guard let self = self else { return }
            self.dismissLoadingView()
            if bool {
                print("Success!")
            } else {
                print("FAILED to change color")
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return settings.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Account") as? AccountTableViewCell else {
                return AccountTableViewCell()
            }

            cell.set(with: user)
            
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Settings") as? SettingsTableViewCell else {
            return SettingsTableViewCell()
        }
        
        let dataValue = settings[indexPath.row]
        
        cell.set(with: dataValue)
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 83
        }
        return 45
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                didSelectChangeCardColor()
            default:
                print("COuld not get index")
            }
        }
    }
}
