//
//  TransactionDataSource.swift
//  NTBank
//
//  Created by Javier Munoz on 7/29/21.
//

import UIKit

class TransactionListDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    var transactions: [Transaction]
    
    init(with transactions: [Transaction]) {
        self.transactions = transactions
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellTypes.transactionCell.rawValue) as? TransactionTableViewCell else {
            return TransactionTableViewCell()
        }
        
        let data = transactions[indexPath.row]

        cell.amountLabel.text = "$\(data.amount)"
        cell.titleLabel.text = data.action
        cell.subtitleLabel.text = "Subaction"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76.0
    }
}
