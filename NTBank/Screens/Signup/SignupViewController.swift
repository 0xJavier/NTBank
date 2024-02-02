//
//  SignupViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/15/21.
//

import UIKit
import Combine

class SignupViewController: UIViewController, SignupInterfaceViewDelegate {
    
    private var viewModel = SignupViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    private var signupInterface = SignupInterfaceView()
    weak var coordinator: AuthCoordinator?
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signupInterface.delegate = self
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func loadView() {
        view = signupInterface
        view.backgroundColor = .systemBackground
    }
    
    private func bindViewModel() {
        viewModel.$state
            .sink { [weak self] state in self?.render(with: state) }
            .store(in: &cancellables)
        
        viewModel.validToSubmit
            .assign(to: \.isEnabled, on: signupInterface.createButton)
            .store(in: &cancellables)
    }
    
    //MARK: -
    func didChangeNameTextfield(name: String) { viewModel.name = name }
    
    func didChangeEmailTextfield(email: String) { viewModel.email = email }
    
    func didChangeColorTextfield(color: String) { viewModel.cardColor = color }
    
    func didChangePasswordTextfield(password: String) { viewModel.password = password }
    
    func didChangeConfirmPasswordTextfield(confirm: String) { viewModel.confirmPassword = confirm }
    
    func didSelectCreateButton() { Task.init { await viewModel.createUser() } }
    
    @MainActor 
    private func render(with state: State) {
        switch state {
        case .loading, .loaded:
            return

        case .error(let error):
            Alert.present(title: "Error", message: error.localizedDescription, from: self)

        case .success:
            coordinator?.userAuthenticated()
        }
    }
}

