//
//  WelcomeScreenViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/15/21.
//

import UIKit
import SwiftUI

protocol WelcomeScreenViewControllerDelegate: WelcomeScreenViewController {
    func didSelectLoginButton()
    func didSelectSignupButton()
}

private extension CGFloat {}

class WelcomeScreenViewController: UIViewController {
    
    lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "background")
        
        return imageView
    }()
    
    lazy var dollarSignImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "dollarsign.circle.fill")
        
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributedTitle = NSMutableAttributedString(string: "Enhance ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 40, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.label])
        
        attributedTitle.append(NSAttributedString(string: "Family Game Nights", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 40, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.systemBlue]))
        
        label.attributedText = attributedTitle
        label.numberOfLines = 2
        
        return label
    }()
    
    lazy var bodyLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome to NTBank. Speed up game banking with our easy to use balance cards."
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 3
        
        return label
    }()
    
    lazy var buttonStackview: UIStackView = {
        let stackview = UIStackView()
        
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.spacing = 16.0
        stackview.alignment = .fill
        stackview.distribution = .fillEqually
        
        return stackview
    }()
    
    lazy var loginButton: NTButton = {
        let button = NTButton(title: "Login")
        
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var signupButton: NTButton = {
        let button = NTButton(title: "Sign Up")
        
        button.addTarget(self, action: #selector(didTapSignupButton), for: .touchUpInside)
        
        return button
    }()
    
    weak var welcomeDelegate: WelcomeScreenViewControllerDelegate?
    
    // MARK: Initalizers
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
    }
    
    private func setUpViews() {
        view.addSubviews(backgroundImage, buttonStackview,
                         bodyLabel, titleLabel, dollarSignImage)
        
        buttonStackview.addArrangedSubviews(loginButton, signupButton)
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        var constraints: [NSLayoutConstraint] = []
        
        constraints += createBackgroundConstraints()
        constraints += createButtonStackViewConstraints()
        constraints += createBodyLabelConstraints()
        constraints += createTitleLabelConstraints()
        constraints += createDollarImageConstraints()
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func createBackgroundConstraints() -> [NSLayoutConstraint] {
        let top = backgroundImage.topAnchor.constraint(equalTo: view.topAnchor)
        let leading = backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let bottom = backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let trailing = backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        
        return [top, leading, bottom, trailing]
    }
    
    private func createButtonStackViewConstraints() -> [NSLayoutConstraint] {
        let bottom = buttonStackview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        let centerX = buttonStackview.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let width = buttonStackview.widthAnchor.constraint(equalToConstant: 343)
        let height = buttonStackview.heightAnchor.constraint(equalToConstant: 116)

        return [bottom, centerX, width, height]
    }
    
    private func createBodyLabelConstraints() -> [NSLayoutConstraint] {
        let leading = bodyLabel.leadingAnchor.constraint(equalTo: buttonStackview.leadingAnchor)
        let bottom = bodyLabel.bottomAnchor.constraint(equalTo: buttonStackview.topAnchor, constant: -100)
        let width = bodyLabel.widthAnchor.constraint(equalToConstant: 300)
        let height = bodyLabel.heightAnchor.constraint(equalToConstant: 80)
        
        return [leading, bottom, width, height]
    }
    
    private func createTitleLabelConstraints() -> [NSLayoutConstraint] {
        let leading = titleLabel.leadingAnchor.constraint(equalTo: buttonStackview.leadingAnchor)
        let bottom = titleLabel.bottomAnchor.constraint(equalTo: bodyLabel.topAnchor)
        let width = titleLabel.widthAnchor.constraint(equalToConstant: 300)
        let height = titleLabel.heightAnchor.constraint(equalToConstant: 110)
        
        return [leading, bottom, width, height]
    }
    
    private func createDollarImageConstraints() -> [NSLayoutConstraint] {
        let leading = dollarSignImage.leadingAnchor.constraint(equalTo: buttonStackview.leadingAnchor)
        let bottom = dollarSignImage.bottomAnchor.constraint(equalTo: titleLabel.topAnchor)
        let width = dollarSignImage.widthAnchor.constraint(equalToConstant: 75)
        let height = dollarSignImage.heightAnchor.constraint(equalToConstant: 75)
        
        return [leading, bottom, width, height]
    }
    
    //MARK: - Selectors
    @objc
    private func didTapLoginButton() {
        welcomeDelegate?.didSelectLoginButton()
    }
    
    @objc
    private func didTapSignupButton() {
        welcomeDelegate?.didSelectSignupButton()
    }
}

//MARK: - SwiftUI Preview
struct WelcomeScreenViewController_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ViewControllerPreview {
                WelcomeScreenViewController()
            }
            ViewControllerPreview {
                WelcomeScreenViewController()
            }
            .preferredColorScheme(.dark)
        }
    }
}
