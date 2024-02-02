//
//  ActionInterfaceView.swift
//  NTBank
//
//  Created by Javier Munoz on 12/5/21.
//

import UIKit

final class ActionInterfaceView: UIView {
    lazy var actionLabel: UILabel = .build { label in
        label.text = "Quick Actions"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
    }
    
    var actionList: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = .init(width: 78, height: 92)
        flowLayout.sectionInset = .init(top: 0, left: 5, bottom: 0, right: 16)
        flowLayout.scrollDirection = .horizontal
        
        let list = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        list.translatesAutoresizingMaskIntoConstraints = false
        list.collectionViewLayout = flowLayout
        list.register(ActionCollectionViewCell.self, forCellWithReuseIdentifier: CellTypes.actionCell.rawValue)
        list.showsHorizontalScrollIndicator = false
        
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
        addSubviews(actionLabel, actionList)

        setUpConstraints()
    }
    
    private func setUpConstraints() {
        createLabelConstraints()
        createListConstraints()
    }
    
    private func createLabelConstraints() {
        NSLayoutConstraint.activate([
            actionLabel.topAnchor.constraint(equalTo: topAnchor),
            actionLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    private func createListConstraints() {
        NSLayoutConstraint.activate([
            actionList.topAnchor.constraint(equalTo: actionLabel.bottomAnchor),
            actionList.leadingAnchor.constraint(equalTo: leadingAnchor),
            actionList.trailingAnchor.constraint(equalTo: trailingAnchor),
            actionList.heightAnchor.constraint(equalToConstant: 105)
        ])
    }
}

#if DEBUG
import SwiftUI

struct ActionInterfaceView_Previews: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            ActionInterfaceView()
        }
    }
}
#endif
