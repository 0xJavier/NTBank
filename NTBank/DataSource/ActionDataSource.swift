//
//  ActionDataSource.swift
//  NTBank
//
//  Created by Javier Munoz on 7/29/21.
//

import UIKit

class ActionDataSource: NSObject, UICollectionViewDataSource {
    var actions: [QuickAction]
    
    init(with actions: [QuickAction]) {
        self.actions = actions
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let content = data[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "action", for: indexPath) as? ActionCollectionViewCell else {
            return ActionCollectionViewCell()
        }
        
        let item = actions[indexPath.row]
        
        cell.cellTitle.text = item.title
        cell.symbolImageView.backgroundView.backgroundColor = item.backgroundColor
        cell.symbolImageView.symbolImageView.image = item.image
        
        return cell
    }
}
