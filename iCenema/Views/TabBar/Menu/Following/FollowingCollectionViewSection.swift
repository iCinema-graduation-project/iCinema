//
//  FollowingCollectionViewSection.swift
//  iCinema
//
//  Created by Ahmed Yamany on 09/04/2023.
//

import UIKit


final class FollowingCollectionViewSection: CompositionalLayoutableSection {
    typealias CellType = CinemaCell

    override init() {
        super.init()
        dataSource = self
        delegate = self
        layout = self
    }
    
}

// MARK: - DataSource
//
extension FollowingCollectionViewSection: CompositionalLayoutableSectionDataSource {
    
    struct ItemsHolder {
        static var itemsHolder: [ResposeType] = []
        static var itemsCount: Int = 0
    }
    
    typealias ResposeType = String
    var items: [ResposeType] {
        get {
            return ItemsHolder.itemsHolder
        }
        set {
            ItemsHolder.itemsHolder = newValue
            itemsCount = items.count
        }
    }
    var itemsCount: Int {
        get {
            return ItemsHolder.itemsCount
        }
        set {
            ItemsHolder.itemsCount = newValue
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(CellType.self, for: indexPath)
        
        return cell
    }
    
    
}

// MARK: - Layout
//
extension FollowingCollectionViewSection: CompositionalLayoutableSectionLayout {
    func itemLayoutInGroup() -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                     leading: .cell.padding.left,
                                                     bottom: 0,
                                                     trailing: .cell.padding.right)
        return item
    }
    
    func groupLayoutInSection() -> NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth((1/2) + 0.05))
        let group: NSCollectionLayoutGroup
        
        if #available(iOS 16.0, *) {
            group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: self.itemLayoutInGroup(), count: 3)
        } else {
            group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: self.itemLayoutInGroup(), count: 2)
        }
        
        group.contentInsets = NSDirectionalEdgeInsets(top: .cell.padding.top,
                                                      leading: 0,
                                                      bottom: .cell.padding.bottom,
                                                      trailing: 0)

        return group
    }
    
    func sectionLayout() -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: self.groupLayoutInSection())
        return section
    }
    
    
}


// MARK: - Delegate
//
extension FollowingCollectionViewSection: CompositionalLayoutableSectionDelegate {
    func registerCell(_ collectionView: UICollectionView) {
        collectionView.register(CellType.self)
    }
    
    func updateItems(_ collectionView: UICollectionView) {
        DispatchQueue.main.async { [ unowned self ] in
            self.items = ["", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]
            collectionView.reloadData()
        }
    }
    
    
}
