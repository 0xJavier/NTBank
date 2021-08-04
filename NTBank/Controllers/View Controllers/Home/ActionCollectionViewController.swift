//
//  ActionCollectionViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/19/21.
//

import UIKit
import SwiftUI

class ActionCollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    var actions: [QuickAction] = [
        QuickAction(title: "Send Money", backgroundColor: .systemBlue, image: UIImage(systemName: "paperplane.fill")!),
        QuickAction(title: "Collect $200", backgroundColor: .systemPink, image: UIImage(systemName: "dollarsign.square.fill")!),
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
        collectionView.register(ActionCollectionViewCell.self, forCellWithReuseIdentifier: CellTypes.actionCell.rawValue)
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
    private func collect200() {
        showLoadingView()
        NetworkManager.shared.collect200 { [weak self] bool in
            guard let self = self else { return }
            self.dismissLoadingView()
            if bool {
                self.presentSimpleAlert(title: "Success!", message: "Successfully collected $200.")
            } else {
                self.presentSimpleAlert(title: "Error", message: "Could not collect $200.")
            }
        }
    }
    
    private func payBank(with amount: Int) {
        showLoadingView()
        NetworkManager.shared.payBank(with: amount) { [weak self] bool in
            guard let self = self else { return }
            self.dismissLoadingView()
            if bool {
                self.presentSimpleAlert(title: "Success!", message: "Successfully paid the bank.")
            } else {
                self.presentSimpleAlert(title: "Error", message: "Could not pay bank.")
            }
        }
    }
    
    private func payLottery(with amount: Int) {
        showLoadingView()
        NetworkManager.shared.payLottery(with: amount) { [weak self] bool in
            guard let self = self else { return }
            self.dismissLoadingView()
            if bool {
                self.presentSimpleAlert(title: "Success!", message: "Successfully paid the lottery.")
            } else {
                self.presentSimpleAlert(title: "Error", message: "Could not pay lottery.")
            }
        }
    }
    
    private func recieveMoney(with amount: Int) {
        showLoadingView()
        NetworkManager.shared.recieveMoney(with: amount) { [weak self] bool in
            guard let self = self else { return }
            self.dismissLoadingView()
            if bool {
                self.presentSimpleAlert(title: "Success!", message: "Successfully recieved money from the bank.")
            } else {
                self.presentSimpleAlert(title: "Error", message: "Could not recieve money.")
            }
        }
    }
    
    private func isAmountBiggerThenZero(_ amount: Int) -> Bool { return amount <= 0 }
}

extension ActionCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            didSelectSendMoney()
        case 1:
            didSelectCollect200()
        case 2:
            didSelectPayBank()
        case 3:
            didSelectPayLottery()
        case 4:
            didSelectRecieveMoney()
        default:
            print("Could not get index for collection view")
        }
    }
}

extension ActionCollectionViewController {
    func didSelectSendMoney() {
        let view = SendMoneyView(onComplete: {self.dismiss( animated: true, completion: nil )})
        let hostingController = UIHostingController(rootView: view)
        present(hostingController, animated: true)
    }
    
    func didSelectCollect200() {
        let title = "Collect $200"
        let message = "Would you like to collect $200?"
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let saveAction = UIAlertAction(title: "Yes", style: .default) { action in
            self.collect200()
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            return
        }

        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)

        DispatchQueue.main.async { self.present(alertController, animated: true) }
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

        DispatchQueue.main.async { self.present(alertController, animated: true) }
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
        
        DispatchQueue.main.async { self.present(alertController, animated: true) }
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
        
        DispatchQueue.main.async { self.present(alertController, animated: true) }
    }
}
