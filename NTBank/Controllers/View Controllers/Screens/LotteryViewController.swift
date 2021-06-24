//
//  LotteryViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/24/21.
//

import UIKit

class LotteryViewController: UIViewController, LotteryInterfaceViewDelegate {
    
    var lotteryInterface = LotteryInterfaceView()
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func loadView() {
        view = lotteryInterface
        title = tabBarItem.title
        view.backgroundColor = .systemBackground
    }
    
    //MARK: - Lottery Delegate
    
    func didSelectCollectButton() { }
}
