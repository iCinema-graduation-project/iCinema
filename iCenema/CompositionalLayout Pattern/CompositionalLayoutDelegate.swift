//
//  CompositionalLayoutDelegate.swift
//  iCinema
//
//  Created by Ahmed Yamany on 07/04/2023.
//

import UIKit


class CompositionalLayoutDelegate: NSObject, UICollectionViewDelegate {
    var target: any CollectionViewCompositionalLayoutProvider
    
    init(_ target: any CollectionViewCompositionalLayoutProvider) {
        self.target = target
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = self.target.getSection(at: indexPath)
        section.collectionView?(collectionView, didSelectItemAt: indexPath)
    }
}
