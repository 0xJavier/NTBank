//
//  ActionCollectionViewController.swift
//  NTBank
//
//  Created by Javier Munoz on 6/19/21.
//

import UIKit


class ActionCollectionViewController: UIViewController {

    static let cellIdentifier = "ActionCollectionViewCell"
    
    // MARK: - Properties
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.register(ActionCollectionViewCell.self, forCellWithReuseIdentifier: Self.cellIdentifier)
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    var data: [QuickAction] = [
        QuickAction(title: "Send Money", backgroundColor: .systemBlue, image: UIImage(systemName: "dollarsign.square.fill")!),
        QuickAction(title: "Pay Bank", backgroundColor: .systemGreen, image: UIImage(systemName: "building.columns.fill")!),
        QuickAction(title: "Pay Lottery", backgroundColor: .systemOrange, image: UIImage(systemName: "car.fill")!),
        QuickAction(title: "Recieve Money", backgroundColor: .systemPurple, image: UIImage(systemName: "chevron.down.square.fill")!)
    ]
    
    // MARK: - Initalizers
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setUpViews()
        
        view.backgroundColor = .systemBackground
        collectionView.backgroundColor = .systemBackground
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    // MARK: - View Helper Functions
        
    private func setUpViews() {
        view.addSubview(collectionView)
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        var constraints: [NSLayoutConstraint] = []
        
        constraints += createCollectionViewConstraints()
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func createCollectionViewConstraints() -> [NSLayoutConstraint] {
        return [
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ]
    }
    
    private func makeLayout() -> UICollectionViewLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = .init(width: 78, height: 92)
        flowLayout.sectionInset = .init(top: 0, left: 5, bottom: 0, right: 16)
        flowLayout.scrollDirection = .horizontal
        
        return flowLayout
    }
}

extension ActionCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let content = data[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.cellIdentifier, for: indexPath) as? ActionCollectionViewCell else {
            return ActionCollectionViewCell()
        }
        
        let item = data[indexPath.row]
        
        cell.cellTitle.text = item.title
        cell.symbolImageView.backgroundView.backgroundColor = item.backgroundColor
        cell.symbolImageView.symbolImageView.image = item.image
        
        return cell
    }
}
