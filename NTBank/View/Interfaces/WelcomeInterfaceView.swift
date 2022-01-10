//
//  WelcomeInterfaceView.swift
//  NTBank
//
//  Created by Javier Munoz on 6/15/21.
//

import UIKit
import SnapKit

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
    
    private lazy var buttonStackview: UIStackView = {
        let stackview = UIStackView()
        
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.spacing = 16.0
        stackview.alignment = .fill
        stackview.distribution = .fillEqually
        
        return stackview
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
        addSubviews(backgroundImage, buttonStackview,
                    bodyLabel, titleLabel, dollarSignImage)
        
        buttonStackview.addArrangedSubviews(loginButton, signupButton)
        
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
        backgroundImage.snp.makeConstraints { image in
            image.edges.equalToSuperview()
        }
    }
    
    private func createButtonStackViewConstraints() {
        buttonStackview.snp.makeConstraints { stackView in
            stackView.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(20)
            stackView.centerX.equalToSuperview()
            stackView.width.equalTo(343)
            stackView.height.equalTo(116)
        }
    }
    
    private func createBodyLabelConstraints() {
        bodyLabel.snp.makeConstraints { label in
            label.leading.equalTo(buttonStackview.snp.leading)
            label.bottom.equalTo(buttonStackview.snp.top).inset(-100)
            label.width.equalTo(300)
            label.height.equalTo(80)
        }
    }
    
    private func createTitleLabelConstraints() {
        titleLabel.snp.makeConstraints { label in
            label.leading.equalTo(buttonStackview.snp.leading)
            label.bottom.equalTo(bodyLabel.snp.top)
            label.width.equalTo(300)
            label.height.equalTo(110)
        }
    }
    
    private func createDollarImageConstraints() {
        dollarSignImage.snp.makeConstraints { image in
            image.leading.equalTo(buttonStackview.snp.leading)
            image.bottom.equalTo(titleLabel.snp.top)
            image.width.height.equalTo(75)
        }
    }
}
