//
//  LoginScreenViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/15/21.
//

import UIKit
import SwiftUI

protocol LoginScreenViewControllerDelegate: LoginScreenViewController {
    func didSelectLoginButton()
    func didSelectForgotPasswordButton()
}

private extension CGFloat {}

class LoginScreenViewController: UIViewController {
    
    lazy var headerView = NTHeaderView()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Log in to your acount"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var emailTextfield = NTTextfield(placeholder: "Email", keyboardType: .emailAddress)
    
    lazy var passwordTextfield = NTSecurefield(placeholder: "Password")
    
    lazy var loginButton: NTButton = {
        let button = NTButton(title: "Login")
        
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var stackview: UIStackView = {
        let stackview = UIStackView()
        
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.distribution = .fillEqually
        stackview.spacing = 10
        
        return stackview
    }()
    
    lazy var seperatorView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        
        return view
    }()
    
    lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Forgot your password?", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(didTapForgotPasswordButton), for: .touchUpInside)
        
        return button
    }()
    
    weak var loginDelegate: LoginScreenViewControllerDelegate?
    
    // MARK: Initalizers
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setUpViews()
    }
    
    private func setUpViews() {
        view.addSubviews(headerView, titleLabel, stackview, seperatorView, forgotPasswordButton)
        
        stackview.addArrangedSubviews(emailTextfield, passwordTextfield, loginButton)
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        var constraints: [NSLayoutConstraint] = []
        
        constraints += createHeaderViewConstraints()
        constraints += createTitleLabelConstraints()
        constraints += createStackViewConstraints()
        constraints += createSeperatorViewConstraints()
        constraints += createForgotPasswordButtonConstraints()
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func createHeaderViewConstraints() -> [NSLayoutConstraint] {
        let top = headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)
        let centerX = headerView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        
        return [top, centerX]
    }
    
    private func createTitleLabelConstraints() -> [NSLayoutConstraint] {
        let top = titleLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10)
        let centerX = titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        
        return [top, centerX]
    }
    
    private func createStackViewConstraints() -> [NSLayoutConstraint] {
        let top = stackview.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32)
        let centerX = stackview.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let width = stackview.widthAnchor.constraint(equalToConstant: 343)
        let height = stackview.heightAnchor.constraint(equalToConstant: 170)
        
        return [top, centerX, width, height]
    }
    
    private func createSeperatorViewConstraints() -> [NSLayoutConstraint] {
        let top = seperatorView.topAnchor.constraint(equalTo: stackview.bottomAnchor, constant: 16)
        let leading = seperatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailing = seperatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let height = seperatorView.heightAnchor.constraint(equalToConstant: 2)
        
        return [top, leading, trailing, height]
    }
    
    private func createForgotPasswordButtonConstraints() -> [NSLayoutConstraint] {
        let top = forgotPasswordButton.topAnchor.constraint(equalTo: seperatorView.bottomAnchor)
        let centerX = forgotPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let width = forgotPasswordButton.widthAnchor.constraint(equalToConstant: 242)
        let height = forgotPasswordButton.heightAnchor.constraint(equalToConstant: 50)
        
        return [top, centerX, width, height]
    }
    
    //MARK: - Selectors
    @objc
    private func didTapLoginButton() {
        loginDelegate?.didSelectLoginButton()
    }
    
    @objc
    private func didTapForgotPasswordButton() {
        loginDelegate?.didSelectForgotPasswordButton()
    }
}

struct LoginScreenViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            LoginScreenViewController()
        }
    }
}
