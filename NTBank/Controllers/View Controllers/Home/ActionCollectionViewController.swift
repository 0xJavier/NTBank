//
//  ActionCollectionViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/19/21.
//

import UIKit

class ActionCollectionViewController: UICollectionViewController {

    static let cellIdentifier = "action"
    
    // MARK: - Properties
    var actions: [QuickAction] = [
        QuickAction(title: "Send Money", backgroundColor: .systemBlue, image: UIImage(systemName: "dollarsign.square.fill")!),
        QuickAction(title: "Pay Bank", backgroundColor: .systemGreen, image: UIImage(systemName: "building.columns.fill")!),
        QuickAction(title: "Pay Lottery", backgroundColor: .systemOrange, image: UIImage(systemName: "car.fill")!),
        QuickAction(title: "Recieve Money", backgroundColor: .systemPurple, image: UIImage(systemName: "chevron.down.square.fill")!)
    ]
    
    lazy var actionDataSource = ActionDataSource(with: actions)
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        collectionView.backgroundColor = .systemBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionViewSetup()
    }
    
    private func collectionViewSetup() {
        collectionView.collectionViewLayout = makeLayout()
        collectionView.dataSource = actionDataSource
        collectionView.register(ActionCollectionViewCell.self, forCellWithReuseIdentifier: Self.cellIdentifier)
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    private func makeLayout() -> UICollectionViewLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = .init(width: 78, height: 92)
        flowLayout.sectionInset = .init(top: 0, left: 5, bottom: 0, right: 16)
        flowLayout.scrollDirection = .horizontal
        
        return flowLayout
    }
    
    //MARK: -
    private func sendMoney(with amount: Int) {
        
    }
    
    private func payBank(with amount: Int) {
        NetworkManager.shared.payBank(with: amount) { bool in
            if bool {
                print("SUCCESS")
            } else {
                print("FAILED")
            }
        }
    }
    
    private func payLottery(with amount: Int) {
        NetworkManager.shared.payLottery(with: amount) { bool in
            if bool {
                print("SUCCESS")
            } else {
                print("FAILED")
            }
        }
    }
    
    private func recieveMoney(with amount: Int) {
        NetworkManager.shared.recieveMoney(with: amount) { bool in
            if bool {
                print("SUCCESS")
            } else {
                print("FAILED")
            }
        }
    }
}

extension ActionCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            didSelectSendMoney()
        case 1:
            didSelectPayBank()
        case 2:
            didSelectPayLottery()
        case 3:
            didSelectRecieveMoney()
        default:
            print("Could not get index for collection view")
        }
    }
}

extension ActionCollectionViewController {
    func didSelectSendMoney() {
        //TODO: Show Send Money View
    }
    
    func didSelectPayBank() {
        let title = "Pay Bank"
        let message = "Please enter the amount you would like to send to the bank"
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alertController.addTextField()
        alertController.textFields![0].keyboardType = .numberPad

        let saveAction = UIAlertAction(title: "Send", style: .default) { action in
            guard let input = alertController.textFields![0].text else { return }
            let amount = Int(input) ?? 0
            self.payBank(with: amount)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            return
        }

        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)

        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
    
    func didSelectPayLottery() {
        let title = "Pay Lottery"
        let message = "Please enter the amount you would like to pay the lottery"
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addTextField()
        alertController.textFields![0].keyboardType = .numberPad
        
        let saveAction = UIAlertAction(title: "Confirm", style: .default) { action in
            guard let input = alertController.textFields![0].text else { return }
            let amount = Int(input) ?? 0
            self.payLottery(with: amount)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            return
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
    
    func didSelectRecieveMoney() {
        let title = "Recieve Money"
        let message = "Please enter the amount you would like to recieve from the bank"
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addTextField()
        alertController.textFields![0].keyboardType = .numberPad
        
        let saveAction = UIAlertAction(title: "Confirm", style: .default) { action in
            guard let input = alertController.textFields![0].text else { return }
            let amount = Int(input) ?? 0
            self.recieveMoney(with: amount)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            return
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
}