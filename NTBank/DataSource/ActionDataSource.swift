//
//  ActionDataSource.swift
//  NTBank
//
//  Created by Javier Munoz on 7/29/21.
//

import UIKit

class ActionDataSource: NSObject, UICollectionViewDataSource {
    var actions: [ImageAction]
    
    init(with actions: [ImageAction]) {
        self.actions = actions
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellTypes.actionCell.rawValue, for: indexPath) as? ActionCollectionViewCell else {
            return ActionCollectionViewCell()
        }
        
        let item = actions[indexPath.row]
        cell.set(with: item)
        return cell
    }
}
