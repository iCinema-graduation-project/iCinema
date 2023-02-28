// 
//  HeaderCollectionViewSection.swift
//  iCinema
//
//  Created by Ahmed Yamany on 27/02/2023.
//

import UIKit

final class PosterCollectionViewSection: NSObject, CollectionViewCompositionalLayout {
    typealias ResposeType = String
    
    // MARK: - Properties
    var items: [ResposeType] = []
    
    override init() {
        super.init()
    }
    
    // MARK: - Section Layout
    func itemLayoutInGroup() -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        return item
    }
    
    func groupLayoutInSection() -> NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(.homePosterSectionHeight))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [self.itemLayoutInGroup()])
        return group
    }
    
    func sectionLayout() -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: self.groupLayoutInSection())
        section.orthogonalScrollingBehavior = .groupPagingCentered
        return section
    }
    
    // MARK: - Data
    func registerCell(_ collectionView: UICollectionView) {
        collectionView.register(PosterCollectionViewCell.self)
    }
    
    func getItems(_ collectionView: UICollectionView) {
        self.items = ["", "", ""]
        collectionView.reloadData()
    }
    
    // MARK: - Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(PosterCollectionViewCell.self, for: indexPath)
        return cell
    }
    
    
}
