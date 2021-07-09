//
//  SignupInterfaceView.swift
//  NTBank
//
//  Created by Javier Munoz on 6/15/21.
//

import UIKit
import SwiftUI

protocol SignupInterfaceViewDelegate: AnyObject {
    func didSelectCreateButton()
}

private extension CGFloat {}

class SignupInterfaceView: UIView {
    
    fileprivate let cardColors = ["blue", "red", "green", "pink", "purple", "orange"]
    
    lazy var headerView = NTHeaderView()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Create an Account"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var nameTextfield = NTTextfield(placeholder: "Name")
    
    lazy var emailTextfield = NTTextfield(placeholder: "Email", keyboardType: .emailAddress)
    
    lazy var colorTextfield = NTTextfield(placeholder: "Card Color")
    
    lazy var colorPickerView = UIPickerView()
    
    lazy var passwordTextfield = NTSecurefield(placeholder: "Password")
    
    lazy var confirmPasswordTextfield = NTSecurefield(placeholder: "Confirm Password")
    
    lazy var stackview: UIStackView = {
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
    
    weak var signupDelegate: SignupInterfaceViewDelegate?

    // MARK: Initalizers
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
        var constraints: [NSLayoutConstraint] = []

        constraints += createHeaderViewConstraints()
        constraints += createTitleLabelConstraints()
        constraints += createStackviewConstraints()
        constraints += createButtonConstraints()

        NSLayoutConstraint.activate(constraints)
    }

    private func createHeaderViewConstraints() -> [NSLayoutConstraint] {
        return [
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            headerView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ]
    }
    
    private func createTitleLabelConstraints() -> [NSLayoutConstraint] {
        return [
            titleLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 14),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ]
    }
    
    private func createStackviewConstraints() -> [NSLayoutConstraint] {
        return [
            stackview.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            stackview.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackview.widthAnchor.constraint(equalToConstant: 343),
            stackview.heightAnchor.constraint(equalToConstant: 250)
        ]
    }
    
    private func createButtonConstraints() -> [NSLayoutConstraint] {
        return [
            createButton.topAnchor.constraint(equalTo: stackview.bottomAnchor, constant: 10),
            createButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            createButton.widthAnchor.constraint(equalToConstant: 343),
            createButton.heightAnchor.constraint(equalToConstant: 50)
        ]
    }

    //MARK: - Selectors
    @objc
    private func didTapCreateButton() {
        signupDelegate?.didSelectCreateButton()
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
    }
}
