//
//  MoviesSection.swift
//  iCinema
//
//  Created by Ahmed Yamany on 28/02/2023.
//

import UIKit

final class MoviesCollectionViewSection: NSObject, CollectionViewCompositionalLayout {
    typealias ResposeType = String
    
    // MARK: - Properties
    var items: [ResposeType] = [] {
        didSet {
            itemsCount = items.count
        }
    }
    
    var itemsCount: Int = 0
    
    // MARK: - initalizer
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
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(.movieCellWidth), heightDimension: .absolute(.movieCellHeight))
        let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [self.itemLayoutInGroup()])
       
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: .moviesPadding, bottom: 0, trailing: .moviesPadding)

        return group
    }
    
    func sectionLayout() -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: self.groupLayoutInSection())
        section.orthogonalScrollingBehavior = .continuous
        
        // MARK: - add supplementary view
        let supplementarySize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(.moviesSupplementaryHeight))
        let supplementaryItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: supplementarySize, elementKind: MovieSectionHeader.identifier, alignment: .top)
        section.boundarySupplementaryItems = [supplementaryItem]
        
        return section
    }
    
    // MARK: - Data
    func registerCell(_ collectionView: UICollectionView) {
        collectionView.register(MovieCell.self)
    }
    
    func registerSupplementaryView(_ collectionView: UICollectionView) {
        collectionView.register(MovieSectionHeader.self, supplementaryViewOfKind: MovieSectionHeader.identifier)
    }
        
    func getItems(_ collectionView: UICollectionView) {
        self.items = ["", "", "", ""]
        collectionView.reloadData()
    }
    
    // MARK: - Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(MovieCell.self, for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let movieSectionHeader = collectionView.dequeueReusableSupplementaryView(MovieSectionHeader.self, ofKind: MovieSectionHeader.identifier, for: indexPath)
        return movieSectionHeader
    }
    
}
