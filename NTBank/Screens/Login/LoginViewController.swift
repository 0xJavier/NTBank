//
//  LoginViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/15/21.
//

import UIKit
import Combine

final class LoginViewController: UIViewController, LoginInterfaceViewDelegate {
    
    private var viewModel = LoginViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    private var loginInterface = LoginInterfaceView()
    weak var coordinator: AuthCoordinator?

    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        loginInterface.delegate = self
        createDismissKeyboardTapGesture()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func loadView() {
        view = loginInterface
        view.backgroundColor = .systemBackground
    }
    
    //MARK: -
    
    private func bindViewModel() {
        viewModel.$state
            .sink { [weak self] state in self?.render(with: state) }
            .store(in: &cancellables)
        
        viewModel.validToSubmit
            .assign(to: \.isEnabled, on: loginInterface.loginButton)
            .store(in: &cancellables)
    }
    
    //MARK: -
    func didSelectLoginButton() {
        Task.init { await viewModel.login() }
    }
    
    func didChangeEmailTextfield(email: String) {
        viewModel.email = email
    }
    
    func didChangePasswordTextfield(password: String) {
        viewModel.password = password
    }
    
    func didSelectForgotPasswordButton() {
        Alert.presentForgotPasswordAlert(from: self) { [weak self] email in
            guard let self = self else { return }
            guard let email = email, !email.isEmpty else { return }
            self.sendResetPasswordLink(with: email)
        }
    }
    
    private func sendResetPasswordLink(with email: String) {
        Task.init { await viewModel.sendPasswordReset(with: email) }
    }
    
    @MainActor
    private func render(with state: LoginState) {
        switch state {
        case .loaded:
            return

        case .loginSuccessfull:
            coordinator?.userAuthenticated()

        case .forgotPasswordSuccessfull:
            Alert.present(title: "Success!", message: "Successfully sent a reset link.", from: self)

        case .failed(let error):
            Alert.present(title: "Error", message: error.localizedDescription, from: self)
        }
    }
}
