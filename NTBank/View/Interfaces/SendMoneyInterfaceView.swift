//
//  SendMoneyInterfaceView.swift
//  NTBank
//
//  Created by Javier Munoz on 12/9/21.
//

import UIKit

protocol SendMoneyInterfaceViewDelegate: UIViewController {
    func didSelectUser(user: User)
    func didChangeAmountTextfield(amount: Int)
    func didSelectSendButton()
}

final class SendMoneyInterfaceView: UIView {
    
    weak var delegate: SendMoneyInterfaceViewDelegate?
    
    var users = [User]()
    
    private lazy var sendMoneyLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Send Money"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        
        return label
    }()
    
    private lazy var userTextfield = NTTextfield(placeholder: "User", keyboardType: .numberPad)
    
    private lazy var amountTextfield: NTTextfield = {
        let textfield = NTTextfield(placeholder: "Amount", keyboardType: .numberPad)
        
        let bar = UIToolbar()
        let dismissKeyboard = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyboard))
        bar.items = [dismissKeyboard]
        bar.sizeToFit()
        textfield.inputAccessoryView = bar
        
        textfield.addTarget(self, action: #selector(didChangeAmountTextfield), for: .editingChanged)
        
        return textfield
    }()
    
    private lazy var namePickerView = UIPickerView()
    
    lazy var sendButton: NTButton = {
        let button = NTButton(title: "Send")
        
        button.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
        
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
    
    @objc private func didTapSendButton() {
        delegate?.didSelectSendButton()
    }
    
    @objc private func dismissKeyboard() {
        amountTextfield.resignFirstResponder()
    }
    
    @objc private func didChangeAmountTextfield() {
        let amount = Int(amountTextfield.text ?? "0") ?? 0
        delegate?.didChangeAmountTextfield(amount: amount)
    }
    
    //MARK: - Layout
    private func setupPickerView() {
        namePickerView.delegate = self
        namePickerView.dataSource = self
        
        userTextfield.inputView = namePickerView
    }
    
    private func setUpViews() {
        addSubviews(sendMoneyLabel, userTextfield, amountTextfield, sendButton)
                
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        createSendMoneyLabelConstraints()
        createUserTextfieldConstraints()
        createAmountTextfieldConstraints()
        createSendButtonConstraints()
    }
    
    private func createSendMoneyLabelConstraints() {
        NSLayoutConstraint.activate([
            sendMoneyLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            sendMoneyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
    }
    
    private func createUserTextfieldConstraints() {
        NSLayoutConstraint.activate([
            userTextfield.topAnchor.constraint(equalTo: sendMoneyLabel.bottomAnchor, constant: 16),
            userTextfield.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            userTextfield.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            userTextfield.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    private func createAmountTextfieldConstraints() {
        NSLayoutConstraint.activate([
            amountTextfield.topAnchor.constraint(equalTo: userTextfield.bottomAnchor, constant: 16),
            amountTextfield.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            amountTextfield.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            amountTextfield.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    private func createSendButtonConstraints() {
        NSLayoutConstraint.activate([
            sendButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            sendButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            sendButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            sendButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}

//MARK: - PickerView
extension SendMoneyInterfaceView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return users.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return users[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        userTextfield.text = users[row].name
        delegate?.didSelectUser(user: users[row])
        userTextfield.resignFirstResponder()
    }
}

#if DEBUG
import SwiftUI

struct SendMoneyInterfaceView_Previews: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            SendMoneyInterfaceView()
        }
    }
}
#endif
