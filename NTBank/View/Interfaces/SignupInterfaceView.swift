//
//  SignupInterfaceView.swift
//  NTBank
//
//  Created by Javier Munoz on 6/15/21.
//

import UIKit
import SnapKit

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
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Create an Account"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        
        return label
    }()
    
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
    
    private lazy var stackview: UIStackView = {
        let stackview = UIStackView()
        
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.distribution = .fillEqually
        stackview.spacing = 4
        
        return stackview
    }()
    
    lazy var createButton: NTButton = {
        let button = NTButton(title: "Create")
        
        button.addTarget(self, action: #selector(didTapCreateButton), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setupPickerview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpViews()
        setupPickerview()
    }
    
    //MARK: - User Interaction
    @objc private func didTapCreateButton() { delegate?.didSelectCreateButton() }
    
    @objc private func didChangeNameTextfield(_ textField: UITextField) { delegate?.didChangeNameTextfield(name: textField.text ?? "") }
    
    @objc func didChangeEmailTextfield(_ textField: UITextField) { delegate?.didChangeEmailTextfield(email: textField.text ?? "") }
    
    @objc func didChangePasswordTextfield(_ textField: UITextField) { delegate?.didChangePasswordTextfield(password: textField.text ?? "") }
    
    @objc func didChangeConfirmPasswordTextfield(_ textField: UITextField) { delegate?.didChangeConfirmPasswordTextfield(confirm: textField.text ?? "") }
    
    //MARK: - Layout
    private func setupPickerview() {
        colorPickerView.delegate = self
        colorPickerView.dataSource = self
        
        colorTextfield.inputView = colorPickerView
    }
    
    private func setUpViews() {
        addSubviews(headerView, titleLabel, stackview, createButton)
        
        stackview.addArrangedSubviews(nameTextfield, emailTextfield, colorTextfield, passwordTextfield, confirmPasswordTextfield)
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        createHeaderViewConstraints()
        createTitleLabelConstraints()
        createStackviewConstraints()
        createButtonConstraints()
    }
    
    private func createHeaderViewConstraints() {
        headerView.snp.makeConstraints { view in
            view.top.equalTo(safeAreaLayoutGuide.snp.top).inset(30)
            view.centerX.equalToSuperview()
        }
    }
    
    private func createTitleLabelConstraints() {
        titleLabel.snp.makeConstraints { label in
            label.top.equalTo(headerView.snp.bottom).inset(-30)
            label.centerX.equalToSuperview()
        }
    }
    
    private func createStackviewConstraints() {
        stackview.snp.makeConstraints { stackView in
            stackView.top.equalTo(titleLabel.snp.bottom).inset(-20)
            stackView.centerX.equalToSuperview()
            stackView.width.equalTo(343)
            stackView.height.equalTo(250)
        }
    }
    
    private func createButtonConstraints() {
        createButton.snp.makeConstraints { button in
            button.top.equalTo(stackview.snp.bottom).inset(-10)
            button.centerX.equalToSuperview()
            button.width.equalTo(343)
            button.height.equalTo(50)
        }
    }
}

//MARK: - Pickerview
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
