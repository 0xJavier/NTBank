//
//  ActionViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 12/8/21.
//

import UIKit
import Combine

final class ActionViewController: UIViewController {
    
    private var viewModel = ActionViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    private var actionInterface = ActionInterfaceView()
    
    lazy var actionDataSource = ActionDataSource(with: viewModel.actions)

    override func viewDidLoad() {
        super.viewDidLoad()

        actionInterface.actionList.dataSource = actionDataSource
        actionInterface.actionList.delegate = self
        bindViewModel()
    }
    
    override func loadView() {
        view = actionInterface
        view.backgroundColor = .systemBackground
    }

    private func bindViewModel() {
        viewModel.$state
            .sink(receiveValue: { [weak self] state in self?.render(with: state) })
            .store(in: &cancellables)
    }
    
    private func render(with state: State) {
        switch state {
        case .loading: return
        case .loaded: return
        case .success: return
        case .error(let error):
            Alert.present(title: "Error", message: error.localizedDescription, from: self)
        }
    }
}

extension ActionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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

extension ActionViewController {
    private func didSelectSendMoney() {
        let sendMoneyVC = SendMoneyViewController()
        present(sendMoneyVC, animated: true)
    }
    
    private func didSelectCollect200() {
        Alert.presentCollect200Alert(from: self) {
            Task.init { await self.viewModel.collect200() }
        }
    }
    
    private func didSelectPayBank() {
        let title = "Pay Bank"
        let message = "Please enter the amount you would like to send to the bank"
        
        Alert.presentTextfieldIntAlert(with: title, message, from: self) { [weak self] amount in
            guard let self = self else { return }
            guard let amount = amount else { return }
            if amount <= 0 { return }
            Task.init { await self.viewModel.payBank(with: amount) }
        }
    }
    
    private func didSelectPayLottery() {
        let title = "Pay Lottery"
        let message = "Please enter the amount you would like to pay the lottery"
        
        Alert.presentTextfieldIntAlert(with: title, message, from: self) { [weak self] amount in
            guard let self = self else { return }
            guard let amount = amount else { return }
            if amount <= 0 { return }
            Task.init { await self.viewModel.payLottery(with: amount) }
        }
    }
    
    private func didSelectReceiveMoney() {
        let title = "Receive Money"
        let message = "Please enter the amount you would like to receive from the bank"
        
        Alert.presentTextfieldIntAlert(with: title, message, from: self) { [weak self] amount in
            guard let self = self else { return }
            guard let amount = amount else { return }
            if amount <= 0 { return }
            Task.init { await self.viewModel.receiveMoney(with: amount) }
        }
    }
}
