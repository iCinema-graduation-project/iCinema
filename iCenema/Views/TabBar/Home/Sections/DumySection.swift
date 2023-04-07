//
//  DumySection.swift
//  iCinema
//
//  Created by Ahmed Yamany on 04/03/2023.
//

import UIKit

final class DummyCollectionViewSection: NSObject, CollectionViewCompositionalLayoutableSection {
    // MARK: - Typealias
    //
    typealias ResposeType = String
    typealias cellType = UICollectionViewCell
    
    // MARK: - Properties
    //
    var items: [ResposeType] = []
    var itemsCount: Int = 0
    
    var hostingViewController: UIViewController? = nil

    
    // MARK: - Section Layout
    //
    func itemLayoutInGroup() -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        return item
    }
    
    func groupLayoutInSection() -> NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(70))
        let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [self.itemLayoutInGroup()])
        return group
    }
    
    func sectionLayout() -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: self.groupLayoutInSection())
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    // MARK: - Data
    //
    func registerCell(_ collectionView: UICollectionView) {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DummyCell")
    }
    
    func registerSupplementaryView(_ collectionView: UICollectionView) { }
        
    func updateItems(_ collectionView: UICollectionView) { }
    
    // MARK: - Data Source
    //
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 0 }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "DummyCell", for: indexPath)
    }
    
    
    
}

