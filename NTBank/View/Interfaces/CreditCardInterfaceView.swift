//
//  CreditCardInterfaceView.swift
//  NTBank
//
//  Created by Javier Munoz on 6/19/21.
//

import UIKit
import SnapKit

final class CreditCardInterfaceView: UIView {
    
    lazy var creditCard = NTCreditCard()
    
    // MARK: User Interaction
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpViews()
    }
    
    //MARK: - Layout
    private func setUpViews() {
        addSubview(creditCard)
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        createCreditCardConstraints()
    }
    
    private func createCreditCardConstraints() {
        creditCard.snp.makeConstraints { card in
            card.center.equalToSuperview()
        }
    }
}
