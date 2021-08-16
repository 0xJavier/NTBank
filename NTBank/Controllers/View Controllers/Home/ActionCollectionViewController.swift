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
        QuickAction(title: "Receive Money", backgroundColor: .systemPurple, image: UIImage(systemName: "chevron.down.square.fill")!)
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
        GameService.shared.collect200 { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(_):
                Alert.present(title: "Success!", message: "Successfully collected $200.", from: self)
            case .failure(let error):
                Alert.present(title: "Error", message: error.localizedDescription, from: self)
            }
        }
    }
    
    private func payBank(with amount: Int) {
        if amount <= 0 {
            Alert.present(title: "Error", message: "Please enter an amount greater then 0.", from: self)
            return
        }
        
        showLoadingView()
        GameService.shared.payBank(with: amount) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(_):
                Alert.present(title: "Success!", message: "Successfully paid the bank.", from: self)
            case .failure(let error):
                Alert.present(title: "Error", message: error.localizedDescription, from: self)
            }
        }
    }
    
    private func payLottery(with amount: Int) {
        if amount <= 0 {
            Alert.present(title: "Error", message: "Please enter an amount greater then 0.", from: self)
            return
        }
        
        showLoadingView()
        GameService.shared.payLottery(with: amount) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(_):
                Alert.present(title: "Success!", message: "Successfully paid the lottery.", from: self)
            case .failure(let error):
                Alert.present(title: "Error", message: error.localizedDescription, from: self)
            }
        }
    }
    
    private func receiveMoney(with amount: Int) {
        if amount <= 0 {
            Alert.present(title: "Error", message: "Please enter an amount greater then 0.", from: self)
            return
        }
        
        showLoadingView()
        GameService.shared.receiveMoney(with: amount) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(_):
                Alert.present(title: "Success!", message: "Successfully received money from the bank.", from: self)
            case .failure(let error):
                Alert.present(title: "Error", message: error.localizedDescription, from: self)
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
            didSelectCollect200()
        case 2:
            didSelectPayBank()
        case 3:
            didSelectPayLottery()
        case 4:
            didSelectReceiveMoney()
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

        let saveAction = UIAlertAction(title: "Yes", style: .default) { _ in
            self.collect200()
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)

        DispatchQueue.main.async { self.present(alertController, animated: true) }
    }
    
    func didSelectPayBank() {
        let title = "Pay Bank"
        let message = "Please enter the amount you would like to send to the bank"
        
        Alert.presentTextfieldIntAlert(with: title, message, from: self) { [weak self] amount in
            guard let amount = amount else { return }
            self?.payBank(with: amount)
        }
    }
    
    func didSelectPayLottery() {
        let title = "Pay Lottery"
        let message = "Please enter the amount you would like to pay the lottery"
        
        Alert.presentTextfieldIntAlert(with: title, message, from: self) { [weak self] amount in
            guard let amount = amount else { return }
            self?.payLottery(with: amount)
        }
    }
    
    func didSelectReceiveMoney() {
        let title = "Receive Money"
        let message = "Please enter the amount you would like to receive from the bank"
        
        Alert.presentTextfieldIntAlert(with: title, message, from: self) { [weak self] amount in
            guard let amount = amount else { return }
            self?.receiveMoney(with: amount)
        }
    }
}
