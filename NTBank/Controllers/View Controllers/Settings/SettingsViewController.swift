//
//  SettingsViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 8/4/21.
//

import UIKit

class SettingsViewController: UITableViewController {

    var settings: [Setting] = [
        Setting(title: "Change Card Color", image: SFSymbolType.creditCard.image, color: .systemBlue),
        Setting(title: "Sign out", image: SFSymbolType.uturnArrow.image, color: .red)
    ]
    
    var user = User.placeholder {
        didSet { tableView.reloadData() }
    }
    
    var newCardColor: String?
    
    //MARK: - Initializer
    init() {
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getUser()
    }
    
    //MARK: - Setup
    func setUpTableView() {
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "Settings")
        tableView.register(AccountTableViewCell.self, forCellReuseIdentifier: "Account")
        tableView.showsVerticalScrollIndicator = false
    }
    
    //MARK: -
    func getUser() {
        UserService.shared.streamUser { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                self.user = user
            case .failure(let error):
                Alert.present(title: "Error", message: error.localizedDescription, from: self)
            }
        }
    }
    
    //MARK: - User Interaction
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
    
    func didSelectSignout() {
        let title = "Signout"
        let message = "Are you sure you want to sign out?"
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let saveAction = UIAlertAction(title: "Yes", style: .default) { _ in
            self.signout()
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)

        DispatchQueue.main.async { self.present(alertController, animated: true) }
    }
    
    func signout() {
        showLoadingView()
        AuthService.shared.signout { [weak self] error in
            guard let self = self else { return }
            self.dismissLoadingView()
            if let error = error {
                Alert.present(title: "Error", message: error.localizedDescription, from: self)
            } else {
                let welcomeVC = WelcomeViewController()
                welcomeVC.modalPresentationStyle = .fullScreen
                self.present(welcomeVC, animated: true)
            }
        }
    }
    
    func changeColor() {
        guard let cardColor = newCardColor else { return }
        showLoadingView()
        UserService.shared.changeUserCardColor(with: cardColor) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(_):
                Alert.present(title: "Success!", message: "Successfully changed card color.", from: self)
            case .failure(let error):
                Alert.present(title: "Error", message: error.localizedDescription, from: self)
            }
        }
    }
}

//MARK: - Tableview
extension SettingsViewController {
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
        
        let setting = settings[indexPath.row]
        
        cell.set(with: setting)
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
            case 1:
                didSelectSignout()
            default:
                print("Could not get index")
            }
        }
    }
}
