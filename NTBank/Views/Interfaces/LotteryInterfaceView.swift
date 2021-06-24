//
//  LotteryInterfaceView.swift
//  NTBank
//
//  Created by Javier Munoz on 6/24/21.
//

import UIKit

protocol LotteryInterfaceViewDelegate: AnyObject {
    func didSelectCollectButton()
}

class LotteryInterfaceView: UIView {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Free Parking Lottery"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    lazy var amountLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$"
        label.font = UIFont.systemFont(ofSize: 50, weight: .bold)
        label.textAlignment = .center
        label.textColor = .systemBlue
        
        return label
    }()
    
    lazy var collectButton: NTButton = {
        let button = NTButton(title: "Collect")
        
        button.addTarget(self, action: #selector(didTapCollectButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stackview = UIStackView()
        
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.distribution = .fill
        stackview.spacing = 16
        
        return stackview
    }()
    
    weak var lotteryDelegate: LotteryInterfaceViewDelegate?
    
    // MARK: Initalizers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpViews()
    }

    //MARK: - Setup
    private func setUpViews() {
        addSubview(stackView)
        
        stackView.addArrangedSubviews(titleLabel, containerView, collectButton)
        containerView.addSubview(amountLabel)
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        var constraints: [NSLayoutConstraint] = []
        
        constraints += createHeightConstraints()
        constraints += createStackViewConstraints()
        constraints += createAmountLabelConstraints()
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func createHeightConstraints() -> [NSLayoutConstraint] {
        let buttonHeight = collectButton.heightAnchor.constraint(equalToConstant: 50)
        let containerHeight = containerView.heightAnchor.constraint(equalToConstant: 96)
        
        return [buttonHeight, containerHeight]
    }
    
    private func createStackViewConstraints() -> [NSLayoutConstraint] {
        let top = stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 85)
        let centerX = stackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        let width = stackView.widthAnchor.constraint(equalToConstant: 343)
        let height = stackView.heightAnchor.constraint(equalToConstant: 230)
        
        
        return [top, centerX, width, height]
    }
    
    private func createAmountLabelConstraints() -> [NSLayoutConstraint] {
        let top = amountLabel.topAnchor.constraint(equalTo: containerView.topAnchor)
        let leading = amountLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
        let bottom = amountLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        let trailing = amountLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        
        return [top, leading, bottom, trailing]
    }
    
    //MARK: - Selectors
    @objc
    private func didTapCollectButton() {
        lotteryDelegate?.didSelectCollectButton()
    }
}
