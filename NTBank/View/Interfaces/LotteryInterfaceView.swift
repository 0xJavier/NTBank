//
//  LotteryInterfaceView.swift
//  NTBank
//
//  Created by Javier Munoz on 6/24/21.
//

import UIKit

protocol LotteryInterfaceViewDelegate: LotteryViewController {
    func didSelectCollectButton()
}

final class LotteryInterfaceView: UIView {
    
    weak var delegate: LotteryInterfaceViewDelegate?

    lazy var titleLabel: UILabel = .build { label in
        label.text = "Free Parking Lottery"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .center
    }
    
    lazy var containerView: UIView = .build { view in
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 10
    }
    
    lazy var amountLabel: UILabel = .build { label in
        label.text = "$"
        label.font = UIFont.systemFont(ofSize: 50, weight: .bold)
        label.textAlignment = .center
        label.textColor = .systemBlue
    }
    
    lazy var collectButton: NTButton = {
        let button = NTButton(title: "Collect")
        
        button.addTarget(self, action: #selector(didTapCollectButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var stackView: UIStackView = .build { view in
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = 16
    }
    
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
    @objc private func didTapCollectButton() {
        delegate?.didSelectCollectButton()
    }

    //MARK: - Layout
    private func setUpViews() {
        addSubview(stackView)
        
        stackView.addArrangedSubviews(titleLabel, containerView, collectButton)
        containerView.addSubview(amountLabel)
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        createHeightConstraints()
        createStackViewConstraints()
        createAmountLabelConstraints()
    }
    
    private func createHeightConstraints() {
        NSLayoutConstraint.activate([
            collectButton.heightAnchor.constraint(equalToConstant: 50),
            containerView.heightAnchor.constraint(equalToConstant: 96)
        ])
    }
    
    private func createStackViewConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 85),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 343),
            stackView.heightAnchor.constraint(equalToConstant: 230),
        ])
    }
    
    private func createAmountLabelConstraints() {
        NSLayoutConstraint.activate([
            amountLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            amountLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            amountLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            amountLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
        ])
    }
}

#if DEBUG
import SwiftUI

struct LotteryInterfaceView_Previews: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            LotteryInterfaceView()
        }
    }
}
#endif
