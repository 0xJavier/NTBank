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
        setupPickerview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpViews()
        setupPickerview()
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
    private func setupPickerview() {
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
        sendMoneyLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(16)
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
    }
    
    private func createUserTextfieldConstraints() {
        userTextfield.snp.makeConstraints { make in
            make.top.equalTo(sendMoneyLabel.snp.bottom).inset(-16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(55)
        }
    }
    
    private func createAmountTextfieldConstraints() {
        amountTextfield.snp.makeConstraints { make in
            make.top.equalTo(userTextfield.snp.bottom).inset(-16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(55)
        }
    }
    
    private func createSendButtonConstraints() {
        sendButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(55)
        }
    }
}

//MARK: - Pickerview
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
