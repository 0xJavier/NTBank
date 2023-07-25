//
//  WelcomeInterfaceView.swift
//  NTBank
//
//  Created by Javier Munoz on 6/15/21.
//

import UIKit

protocol WelcomeInterfaceViewDelegate: WelcomeViewController {
    func didSelectLoginButton()
    func didSelectSignupButton()
}

final class WelcomeInterfaceView: UIView {
    
    weak var delegate: WelcomeInterfaceViewDelegate?
    
    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "background")
        
        return imageView
    }()
    
    private lazy var dollarSignImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "dollarsign.circle.fill")
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributedTitle = NSMutableAttributedString(string: "Enhance ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 40, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.label])
        
        attributedTitle.append(NSAttributedString(string: "Family Game Nights", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 40, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.systemBlue]))
        
        label.attributedText = attributedTitle
        label.numberOfLines = 2
        
        return label
    }()
    
    private lazy var bodyLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome to NTBank. Speed up game banking with our easy to use balance cards."
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 3
        
        return label
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16.0
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private lazy var loginButton: NTButton = {
        let button = NTButton(title: "Login")
        
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var signupButton: NTButton = {
        let button = NTButton(title: "Sign Up")
        
        button.addTarget(self, action: #selector(didTapSignupButton), for: .touchUpInside)
        
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
    
    @objc private func didTapSignupButton() {
        delegate?.didSelectSignupButton()
    }
    
    //MARK: - Layout
    private func setUpViews() {
        addSubviews(backgroundImage, buttonStackView,
                    bodyLabel, titleLabel, dollarSignImage)
        
        buttonStackView.addArrangedSubviews(loginButton, signupButton)
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        createBackgroundConstraints()
        createButtonStackViewConstraints()
        createBodyLabelConstraints()
        createTitleLabelConstraints()
        createDollarImageConstraints()
    }
    
    private func createBackgroundConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func createButtonStackViewConstraints() {
        NSLayoutConstraint.activate([
            buttonStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            buttonStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonStackView.widthAnchor.constraint(equalToConstant: 343),
            buttonStackView.heightAnchor.constraint(equalToConstant: 116)
        ])
    }
    
    private func createBodyLabelConstraints() {
        NSLayoutConstraint.activate([
            bodyLabel.leadingAnchor.constraint(equalTo: buttonStackView.leadingAnchor),
            bodyLabel.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: -100),
            bodyLabel.widthAnchor.constraint(equalToConstant: 300),
            bodyLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func createTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: buttonStackView.leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bodyLabel.topAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 300),
            titleLabel.heightAnchor.constraint(equalToConstant: 110)
        ])
    }
    
    private func createDollarImageConstraints() {
        NSLayoutConstraint.activate([
            dollarSignImage.leadingAnchor.constraint(equalTo: buttonStackView.leadingAnchor),
            dollarSignImage.bottomAnchor.constraint(equalTo: titleLabel.topAnchor),
            dollarSignImage.widthAnchor.constraint(equalToConstant: 75),
            dollarSignImage.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
}

#if DEBUG
import SwiftUI

struct WelcomeInterfaceView_Previews: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            WelcomeInterfaceView()
        }
    }
}
#endif
