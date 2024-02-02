//
//  LotteryViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/24/21.
//

import UIKit
import Combine

final class LotteryViewController: UIViewController, LotteryInterfaceViewDelegate {
    
    private var viewModel = LotteryViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    private var lotteryInterface = LotteryInterfaceView()
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        lotteryInterface.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Task.init { await viewModel.fetchLotteryAmount() }
    }

    override func loadView() {
        view = lotteryInterface
        view.backgroundColor = .systemBackground
    }
    
    //MARK: -
    
    private func bindViewModel() {
        viewModel.$state
            .sink { [weak self] state in self?.render(state) }
            .store(in: &cancellables)
        
        viewModel.$amount
            .map { (amount) -> Bool in return amount > 0 }
            .assign(to: \.isEnabled, on: lotteryInterface.collectButton)
            .store(in: &cancellables)
    }
    
    @MainActor private func render(_ state: State) {
        switch state {
        case .loading: return
        case .loaded:
            lotteryInterface.amountLabel.text = "$\(viewModel.amount)"
        case .error(let error):
            Alert.present(title: "Error", message: error.localizedDescription, from: self)
        case .success:
            Alert.present(title: "Success", message: "Successfully collected lottery", from: self)
        }
    }
    
    //MARK: - Lottery Interface Delegate
    func didSelectCollectButton() {
        Alert.presentCollectLotteryAlert(from: self) { [weak self] in
            guard let self = self else { return }
            Task.init { await self.viewModel.collectLottery() }
        }
    }
}
