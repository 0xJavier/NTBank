//
//  ActionInterfaceView.swift
//  NTBank
//
//  Created by Javier Munoz on 12/5/21.
//

import UIKit

final class ActionInterfaceView: UIView {
    lazy var actionLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Quick Actions"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        
        return label
    }()
    
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
        actionLabel.snp.makeConstraints { label in
            label.leading.equalToSuperview()
            label.top.trailing.equalToSuperview()
            label.height.equalTo(24)
        }
    }
    
    private func createListConstraints() {
        actionList.snp.makeConstraints { list in
            list.top.equalTo(actionLabel.snp.bottom)
            list.leading.trailing.equalToSuperview()
            list.height.equalTo(105)
        }
    }
}
