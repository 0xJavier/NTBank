//
//  LotteryViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/24/21.
//

import UIKit

class LotteryViewController: UIViewController, LotteryInterfaceViewDelegate {
    
    var lotteryInterface = LotteryInterfaceView()
    
    var lotteryAmount = 0 {
        didSet { render() }
    }
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lotteryInterface.lotteryDelegate = self
        
        streamLotteryChanges()
    }

    override func loadView() {
        view = lotteryInterface
        view.backgroundColor = .systemBackground
    }
    
    func streamLotteryChanges() {
        NetworkManager.shared.streamLottery { [weak self] amount in
            guard let self = self else { return }
            if let amount = amount {
                self.lotteryAmount = amount
            } else {
                print("COULD NOT LOAD AMOUNT")
                self.lotteryAmount = 0
            }
        }
    }
    
    func render() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.lotteryInterface.amountLabel.text = "$\(self.lotteryAmount)"
        }
    }
    
    //MARK: - Lottery Interface Delegate
    func didSelectCollectButton() {
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

        DispatchQueue.main.async { self.present(alertController, animated: true) }
    }
    
    func collectLottery() {
        showLoadingView()
        NetworkManager.shared.collectLottery(with: lotteryAmount) { [weak self] bool in
            guard let self = self else { return }
            self.dismissLoadingView()
            if bool {
                self.render()
                self.presentSimpleAlert(title: "Success", message: "Successfully collected lottery")
            } else {
                self.presentSimpleAlert(title: "Error", message: "Could not collect lotter.")
            }
        }
    }
}
