//
//  CompositionalLayoutDataSource.swift
//  iCinema
//
//  Created by Ahmed Yamany on 07/04/2023.
//

import UIKit


class CompositionalLayoutDataSource: NSObject, UICollectionViewDataSource {
    
    var target: any CollectionViewCompositionalLayoutProvider
    
    init(_ target: any CollectionViewCompositionalLayoutProvider) {
        self.target = target
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.target.compositionalLayoutSections.count
    }
    
    // FIXME: - items count
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let compositionalSection = self.target.getSection(at: IndexPath(item: 0, section: section))
        return compositionalSection.itemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = self.target.getSection(at: indexPath)
        return section.collectionView(collectionView, cellForItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = self.target.getSection(at: indexPath)
        return section.collectionView?(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath) ?? UICollectionReusableView()
    }
    
}

