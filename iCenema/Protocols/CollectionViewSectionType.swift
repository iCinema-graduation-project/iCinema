//
//  CollectionViewModelSectionType.swift
//  iCinema
//
//  Created by Ahmed Yamany on 05/02/2023.
//

import UIKit

/// This Protocol defines the behavior and structure of sections in a UICollectionView.
/// Using this protocol can lead to better organization and abstraction of your code,
/// as well as making it easier to reuse and maintain.
/// You can create multiple objects conforming to this protocol
/// and switch between them to show different sections in the same collection view,
///
protocol CollectionViewSectionType: AnyObject, UICollectionViewDelegate, UICollectionViewDataSource {
    associatedtype ResposeType
    var items: [ResposeType] { get }
    
    func itemLayoutInGroup() -> NSCollectionLayoutItem
    func groupLayoutInSection() -> NSCollectionLayoutGroup
    func sectionLayout() -> NSCollectionLayoutSection
    func registerCell(_ collectionView: UICollectionView)
    func networkRequest(_ collectionView: UICollectionView)
}


/// defines the behavior of collectionView
protocol CollectionViewSectionsDataSource {
    var sections: [any CollectionViewSectionType] { get set }
}

extension CollectionViewSectionsDataSource {
    
    func registerCells(_ collectionView: UICollectionView) {
        sections.forEach { $0.registerCell(collectionView) }
    }
    
    func getSection(at indexPath: IndexPath) -> any CollectionViewSectionType {
        return self.sections[indexPath.section]
    }
    
    func collectionViewCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [self]  sectionIndex, layoutEnvironment in
            return self.getSection(at: IndexPath(row: 0, section: sectionIndex)).sectionLayout()
        }
        return layout
    }

}
