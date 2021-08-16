//
//  LotteryViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/24/21.
//

import UIKit

class LotteryViewController: UIViewController {
    
    var lotteryInterface = LotteryInterfaceView()
    
    var lotteryAmount = 0 {
        didSet { render() }
    }
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        streamLotteryChanges()
        configureDidSelectCollectButton()
    }

    override func loadView() {
        view = lotteryInterface
        view.backgroundColor = .systemBackground
    }
    
    func streamLotteryChanges() {
        LotteryService.shared.streamLottery { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let amount):
                self.lotteryAmount = amount
            case .failure(let error):
                Alert.present(title: "Error", message: error.localizedDescription, from: self)
            }
        }
    }
    
    func render() {
        DispatchQueue.main.async { 
            self.lotteryInterface.amountLabel.text = "$\(self.lotteryAmount)"
        }
    }
    
    //MARK: - Lottery Interface Delegate
    func configureDidSelectCollectButton() {
        lotteryInterface.didSelectCollectButton = { [weak self] in
            let title = "Collect Lottery"
            let message = "Are you sure you want to collect the lottery"

            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

            let collectAction = UIAlertAction(title: "Collect", style: .default) { [weak self] _ in
                guard let self = self else { return }
                self.collectLottery()
            }

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                return
            }

            alertController.addAction(cancelAction)
            alertController.addAction(collectAction)

            DispatchQueue.main.async { self?.present(alertController, animated: true) }
        }
    }
    
    func collectLottery() {
        showLoadingView()
        LotteryService.shared.collectLottery(with: lotteryAmount) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.render()
                Alert.present(title: "Success", message: "Successfully collected lottery", from: self)
            case .failure(let error):
                Alert.present(title: "Error", message: error.localizedDescription, from: self)
            }
        }
    }
}
