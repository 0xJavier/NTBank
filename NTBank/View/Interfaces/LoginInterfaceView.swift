//
//  LoginInterfaceView.swift
//  NTBank
//
//  Created by Javier Munoz on 6/15/21.
//

import UIKit
import SnapKit

protocol LoginInterfaceViewDelegate: UIViewController {
    func didSelectLoginButton()
    func didSelectForgotPasswordButton()
    func didChangeEmailTextfield(email: String)
    func didChangePasswordTextfield(password: String)
}

final class LoginInterfaceView: UIView {
    
    weak var delegate: LoginInterfaceViewDelegate?
    
    private lazy var headerView = NTHeaderView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Log in to your account"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var emailTextfield: NTTextfield = {
        let textfield = NTTextfield(placeholder: "Email", keyboardType: .emailAddress)
        
        textfield.addTarget(self, action: #selector(didChangeEmailTextfield), for: .editingChanged)
        
        return textfield
    }()
    
    private lazy var passwordTextfield: NTSecurefield = {
        let textfield = NTSecurefield(placeholder: "Password")
        
        textfield.addTarget(self, action: #selector(didChangePasswordTextfield), for: .editingChanged)
        
        return textfield
    }()
    
    lazy var loginButton: NTButton = {
        let button = NTButton(title: "Login")
        
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        return stackView
    }()
    
    private lazy var separatorView: UIView = {
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
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpViews()
    }
    
    //MARK: - User Interaction
    @objc private func didTapLoginButton() {
        delegate?.didSelectLoginButton()
    }
    
    @objc private func didTapForgotPasswordButton() {
        delegate?.didSelectForgotPasswordButton()
    }
    
    @objc private func didChangeEmailTextfield() {
        delegate?.didChangeEmailTextfield(email: emailTextfield.text ?? "")
    }
    
    @objc private func didChangePasswordTextfield() {
        delegate?.didChangePasswordTextfield(password: passwordTextfield.text ?? "")
    }
    
    //MARK: - Layout
    private func setUpViews() {
        addSubviews(headerView, titleLabel, stackView, separatorView, forgotPasswordButton)
        
        stackView.addArrangedSubviews(emailTextfield, passwordTextfield, loginButton)
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        createHeaderViewConstraints()
        createTitleLabelConstraints()
        createStackViewConstraints()
        createSeparatorViewConstraints()
        createForgotPasswordButtonConstraints()
    }
    
    private func createHeaderViewConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            headerView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func createTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func createStackViewConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 343),
            stackView.heightAnchor.constraint(equalToConstant: 170)
        ])
    }
    
    private func createSeparatorViewConstraints() {
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
    
    private func createForgotPasswordButtonConstraints() {
        NSLayoutConstraint.activate([
            forgotPasswordButton.topAnchor.constraint(equalTo: separatorView.bottomAnchor),
            forgotPasswordButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            forgotPasswordButton.widthAnchor.constraint(equalToConstant: 242),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

#if DEBUG
import SwiftUI

struct LoginInterfaceView_Previews: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            LoginInterfaceView()
        }
    }
}
#endif
