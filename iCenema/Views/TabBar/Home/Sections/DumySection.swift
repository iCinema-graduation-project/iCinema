//
//  DumySection.swift
//  iCinema
//
//  Created by Ahmed Yamany on 04/03/2023.
//

import UIKit

final class DummyCollectionViewSection: CompositionalLayoutableSection {
    
    override init() {
        super.init()
        layout = self
    }
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
    
}

extension DummyCollectionViewSection : CompositionalLayoutableSectionLayout { }

