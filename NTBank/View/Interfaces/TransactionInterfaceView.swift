//
//  TransactionInterfaceView.swift
//  NTBank
//
//  Created by Javier Munoz on 12/5/21.
//

import UIKit

final class TransactionInterfaceView: UIView {

    lazy var transactionLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Latest Transactions"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        
        return label
    }()
    
    lazy var transactionList: UITableView = {
        let list = UITableView()
        
        list.register(TransactionTableViewCell.self, forCellReuseIdentifier: CellTypes.transactionCell.rawValue)
        list.showsVerticalScrollIndicator = false
        list.allowsSelection = false
        list.tableFooterView = UIView(frame: .zero)
        list.backgroundColor = .systemBackground
        
        return list
    }()
    
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
        addSubviews(transactionLabel, transactionList)
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        createLabelConstraints()
        createListConstraints()
    }
    
    private func createLabelConstraints() {
        transactionLabel.snp.makeConstraints { label in
            label.leading.equalToSuperview().inset(16)
            label.top.trailing.equalToSuperview()
        }
    }
    
    private func createListConstraints() {
        transactionList.snp.makeConstraints { list in
            list.top.equalTo(transactionLabel.snp.bottom)
            list.leading.bottom.trailing.equalToSuperview()
        }
    }
}
