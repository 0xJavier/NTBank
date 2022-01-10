//
//  SendMoneyViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 12/9/21.
//

import UIKit
import Combine

final class SendMoneyViewController: UIViewController, SendMoneyInterfaceViewDelegate {
    
    private var viewModel = SendMoneyViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    private var sendMoneyView = SendMoneyInterfaceView()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        sendMoneyView.delegate = self
        bindViewModel()
        
        Task.init {
            let users = await viewModel.service.fetchUsers()
            sendMoneyView.users = users
        }
        
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [ .medium() ]
            presentationController.prefersGrabberVisible = true
        }
    }
    
    override func loadView() {
        view = sendMoneyView
    }
    
    private func bindViewModel() {
        viewModel.$state
            .sink { [weak self] state in self?.render(with: state) }
            .store(in: &cancellables)
        
        viewModel.validToSubmit
            .assign(to: \.isEnabled, on: sendMoneyView.sendButton)
            .store(in: &cancellables)
    }
    
    func didSelectUser(user: User) { viewModel.selectedUser = user }
    
    func didChangeAmountTextfield(amount: Int) { viewModel.amount = amount }
    
    func didSelectSendButton() {
        Task.init { await viewModel.sendMoney() }
    }
    
    private func render(with state: State) {
        switch state {
        case .loading: return
        case .loaded: return
        case .error(let error):
            Alert.present(title: "Error", message: error.localizedDescription, from: self)
        case .success:
            dismiss(animated: true)
        }
    }
}
