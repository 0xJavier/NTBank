//
//  LotteryInterfaceView.swift
//  NTBank
//
//  Created by Javier Munoz on 6/24/21.
//

import UIKit
import SnapKit

protocol LotteryInterfaceViewDelegate: LotteryViewController {
    func didSelectCollectButton()
}

final class LotteryInterfaceView: UIView {
    
    weak var delegate: LotteryInterfaceViewDelegate?

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
        collectButton.snp.makeConstraints { button in
            button.height.equalTo(50)
        }
        
        containerView.snp.makeConstraints { view in
            view.height.equalTo(96)
        }
    }
    
    private func createStackViewConstraints() {
        stackView.snp.makeConstraints { stackView in
            stackView.top.equalTo(safeAreaLayoutGuide.snp.top).inset(85)
            stackView.centerX.equalToSuperview()
            stackView.width.equalTo(343)
            stackView.height.equalTo(230)
        }
    }
    
    private func createAmountLabelConstraints() {
        amountLabel.snp.makeConstraints { label in
            label.edges.equalToSuperview()
        }
    }
}
