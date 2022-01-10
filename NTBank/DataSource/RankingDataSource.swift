//
//  RankingDataSource.swift
//  NTBank
//
//  Created by Javier Munoz on 12/30/21.
//

import UIKit

final class RankingDataSource: NSObject, UITableViewDataSource {
    var users: [User]
    
    init(with users: [User]) {
        self.users = users
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellTypes.rankingCell.rawValue) as? RankingTableViewCell else {
            return RankingTableViewCell()
        }
        
        let player = users[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        
        content.text = "\(indexPath.row + 1). \(player.name)"
        content.secondaryText = "$\(player.balance)"
        
        cell.contentConfiguration = content
        
        return cell
    }
}
