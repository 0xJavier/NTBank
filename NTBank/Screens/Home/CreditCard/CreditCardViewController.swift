//
//  CreditCardViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 12/8/21.
//

import UIKit
import Combine

final class CreditCardViewController: UIViewController {
    
    private var viewModel = CreditCardViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    private var creditCardInterface = CreditCardInterfaceView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
    }

    override func loadView() {
        view = creditCardInterface
        view.backgroundColor = .systemBackground
    }
    
    private func bindViewModel() {
        viewModel.$user
            .sink { [weak self] user in self?.creditCardInterface.creditCard.set(with: user) }
            .store(in: &cancellables)
    }
}
