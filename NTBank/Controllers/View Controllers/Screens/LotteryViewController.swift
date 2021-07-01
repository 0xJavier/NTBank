//
//  LotteryViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/24/21.
//

import UIKit

class LotteryViewController: UIViewController, LotteryInterfaceViewDelegate, LotteryModelControllerDelegate {
    
    var lotteryInterface = LotteryInterfaceView()
    
    var lotteryModelController = LotteryModelController()
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lotteryInterface.lotteryDelegate = self
        lotteryModelController.lotteryDelegate = self
        
        render()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        render()
    }

    override func loadView() {
        view = lotteryInterface
        title = tabBarItem.title
        view.backgroundColor = .systemBackground
    }
    
    func render() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.lotteryInterface.amountLabel.text = "$\(self.lotteryModelController.amount)"
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
        lotteryModelController.collectLottery { [weak self] in
            guard let self = self else { return }
            let title = "Success"
            let message = "Successfully collected lottery"
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

            let confirmAction = UIAlertAction(title: "Okay", style: .default) { _ in
                return
            }

            alertController.addAction(confirmAction)

            DispatchQueue.main.async { self.present(alertController, animated: true) }
            self.render()
        }
    }
    
    //MARK: - Lottery Model Delegate
    
    func didFetchLottery() {
        render()
    }
}
