//
//  LoginInterfaceView.swift
//  NTBank
//
//  Created by Javier Munoz on 6/15/21.
//

import UIKit

class LoginInterfaceView: UIView {
    
    var didSelectLoginButton: (() -> Void)?
    
    var didSelectForgotPasswordButton: (() -> Void)?
    
    var email: String? { return emailTextfield.text }
    
    var password: String? { return passwordTextfield.text }
    
    private lazy var headerView = NTHeaderView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Log in to your acount"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var emailTextfield = NTTextfield(placeholder: "Email", keyboardType: .emailAddress)
    
    private lazy var passwordTextfield = NTSecurefield(placeholder: "Password")
    
    private lazy var loginButton: NTButton = {
        let button = NTButton(title: "Login")
        
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var stackview: UIStackView = {
        let stackview = UIStackView()
        
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.distribution = .fillEqually
        stackview.spacing = 10
        
        return stackview
    }()
    
    private lazy var seperatorView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        
        return view
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Forgot your password?", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(didTapForgotPasswordButton), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: Initalizers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpViews()
    }
    
    //MARK: - Selectors
    @objc private func didTapLoginButton() {
        didSelectLoginButton?()
    }
    
    @objc private func didTapForgotPasswordButton() {
        didSelectForgotPasswordButton?()
    }
    
    private func setUpViews() {
        addSubviews(headerView, titleLabel, stackview, seperatorView, forgotPasswordButton)
        
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
        let top = headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30)
        let centerX = headerView.centerXAnchor.constraint(equalTo: centerXAnchor)
        
        return [top, centerX]
    }
    
    private func createTitleLabelConstraints() -> [NSLayoutConstraint] {
        let top = titleLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10)
        let centerX = titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        
        return [top, centerX]
    }
    
    private func createStackViewConstraints() -> [NSLayoutConstraint] {
        let top = stackview.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32)
        let centerX = stackview.centerXAnchor.constraint(equalTo: centerXAnchor)
        let width = stackview.widthAnchor.constraint(equalToConstant: 343)
        let height = stackview.heightAnchor.constraint(equalToConstant: 170)
        
        return [top, centerX, width, height]
    }
    
    private func createSeperatorViewConstraints() -> [NSLayoutConstraint] {
        let top = seperatorView.topAnchor.constraint(equalTo: stackview.bottomAnchor, constant: 16)
        let leading = seperatorView.leadingAnchor.constraint(equalTo: leadingAnchor)
        let trailing = seperatorView.trailingAnchor.constraint(equalTo: trailingAnchor)
        let height = seperatorView.heightAnchor.constraint(equalToConstant: 2)
        
        return [top, leading, trailing, height]
    }
    
    private func createForgotPasswordButtonConstraints() -> [NSLayoutConstraint] {
        let top = forgotPasswordButton.topAnchor.constraint(equalTo: seperatorView.bottomAnchor)
        let centerX = forgotPasswordButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        let width = forgotPasswordButton.widthAnchor.constraint(equalToConstant: 242)
        let height = forgotPasswordButton.heightAnchor.constraint(equalToConstant: 50)
        
        return [top, centerX, width, height]
    }
}
