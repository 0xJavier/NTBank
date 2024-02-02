//
//  SignupInterfaceView.swift
//  NTBank
//
//  Created by Javier Munoz on 6/15/21.
//

import UIKit

protocol SignupInterfaceViewDelegate: UIViewController {
    func didSelectCreateButton()
    func didChangeNameTextfield(name: String)
    func didChangeEmailTextfield(email: String)
    func didChangeColorTextfield(color: String)
    func didChangePasswordTextfield(password: String)
    func didChangeConfirmPasswordTextfield(confirm: String)
}

final class SignupInterfaceView: UIView {
    
    weak var delegate: SignupInterfaceViewDelegate?
    
    private let cardColors: [String] = CardColor.allCases.map { $0.rawValue }
    
    private lazy var headerView = NTHeaderView()
    
    private lazy var titleLabel: UILabel = .build { label in
        label.text = "Create an Account"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
    }
    
    private lazy var nameTextfield: NTTextfield = {
        let textfield = NTTextfield(placeholder: "Name")
        
        textfield.addTarget(self, action: #selector(didChangeNameTextfield(_:)), for: .editingChanged)
        
        return textfield
    }()
    
    private lazy var emailTextfield: NTTextfield = {
        let textfield = NTTextfield(placeholder: "Email", keyboardType: .emailAddress)
        
        textfield.addTarget(self, action: #selector(didChangeEmailTextfield(_:)), for: .editingChanged)
        
        return textfield
    }()
    
    private lazy var colorTextfield = NTTextfield(placeholder: "Card Color")
    
    private lazy var colorPickerView = UIPickerView()
    
    private lazy var passwordTextfield: NTSecurefield = {
        let textfield = NTSecurefield(placeholder: "Password")
        
        textfield.addTarget(self, action: #selector(didChangePasswordTextfield(_:)), for: .editingChanged)
        
        return textfield
    }()
    
    private lazy var confirmPasswordTextfield: NTSecurefield = {
        let textfield = NTSecurefield(placeholder: "Confirm Password")
        
        textfield.addTarget(self, action: #selector(didChangeConfirmPasswordTextfield(_:)), for: .editingChanged)
        
        return textfield
    }()
    
    private lazy var stackView: UIStackView = .build { view in
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = 4
    }
    
    lazy var createButton: NTButton = {
        let button = NTButton(title: "Create")
        
        button.addTarget(self, action: #selector(didTapCreateButton), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setupPickerView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpViews()
        setupPickerView()
    }
    
    //MARK: - User Interaction
    @objc private func didTapCreateButton() { delegate?.didSelectCreateButton() }
    
    @objc private func didChangeNameTextfield(_ textField: UITextField) { delegate?.didChangeNameTextfield(name: textField.text ?? "") }
    
    @objc func didChangeEmailTextfield(_ textField: UITextField) { delegate?.didChangeEmailTextfield(email: textField.text ?? "") }
    
    @objc func didChangePasswordTextfield(_ textField: UITextField) { delegate?.didChangePasswordTextfield(password: textField.text ?? "") }
    
    @objc func didChangeConfirmPasswordTextfield(_ textField: UITextField) { delegate?.didChangeConfirmPasswordTextfield(confirm: textField.text ?? "") }
    
    //MARK: - Layout
    private func setupPickerView() {
        colorPickerView.delegate = self
        colorPickerView.dataSource = self
        
        colorTextfield.inputView = colorPickerView
    }
    
    private func setUpViews() {
        addSubviews(headerView, titleLabel, stackView, createButton)
        
        stackView.addArrangedSubviews(nameTextfield, emailTextfield, colorTextfield, passwordTextfield, confirmPasswordTextfield)
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        createHeaderViewConstraints()
        createTitleLabelConstraints()
        createStackviewConstraints()
        createButtonConstraints()
    }
    
    private func createHeaderViewConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            headerView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func createTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 30),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func createStackviewConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 343),
            stackView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    private func createButtonConstraints() {
        NSLayoutConstraint.activate([
            createButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            createButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            createButton.widthAnchor.constraint(equalToConstant: 343),
            createButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

//MARK: - PickerView
extension SignupInterfaceView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cardColors.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cardColors[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        colorTextfield.text = cardColors[row]
        colorTextfield.resignFirstResponder()
        delegate?.didChangeColorTextfield(color: cardColors[row])
    }
}

#if DEBUG
import SwiftUI

struct SignupInterfaceView_Previews: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            SignupInterfaceView()
        }
    }
}
#endif
