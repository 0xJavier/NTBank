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
        label.text = "Log in to your acount"
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
        addSubviews(headerView, titleLabel, stackview, seperatorView, forgotPasswordButton)
        
        stackview.addArrangedSubviews(emailTextfield, passwordTextfield, loginButton)
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        createHeaderViewConstraints()
        createTitleLabelConstraints()
        createStackViewConstraints()
        createSeperatorViewConstraints()
        createForgotPasswordButtonConstraints()
    }
    
    private func createHeaderViewConstraints() {
        headerView.snp.makeConstraints { view in
            view.top.equalTo(safeAreaLayoutGuide.snp.top).inset(30)
            view.centerX.equalToSuperview()
        }
    }
    
    private func createTitleLabelConstraints() {
        titleLabel.snp.makeConstraints { label in
            label.top.equalTo(headerView.snp.bottom).inset(-10)
            label.centerX.equalToSuperview()
        }
    }
    
    private func createStackViewConstraints() {
        stackview.snp.makeConstraints { stackView in
            stackView.top.equalTo(titleLabel.snp.bottom).inset(-32)
            stackView.centerX.equalToSuperview()
            stackView.width.equalTo(343)
            stackView.height.equalTo(170)
        }
    }
    
    private func createSeperatorViewConstraints() {
        seperatorView.snp.makeConstraints { view in
            view.top.equalTo(stackview.snp.bottom).inset(-16)
            view.leading.trailing.equalToSuperview()
            view.height.equalTo(2)
        }
    }
    
    private func createForgotPasswordButtonConstraints() {
        forgotPasswordButton.snp.makeConstraints { button in
            button.top.equalTo(seperatorView.snp.bottom)
            button.centerX.equalToSuperview()
            button.width.equalTo(242)
            button.height.equalTo(50)
        }
    }
}
