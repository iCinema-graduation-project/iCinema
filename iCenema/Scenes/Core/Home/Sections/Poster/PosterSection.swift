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
    var posterPaginationView: PosterPaginationView?
    
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
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(.homePosterSectionHeight))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [self.itemLayoutInGroup()])
        return group
    }
    
    func sectionLayout() -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: self.groupLayoutInSection())
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        // MARK: - add supplementary view
        let supplementarySize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))
        let supplementaryItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: supplementarySize, elementKind: PosterPaginationView.identifier, alignment: .bottom)
        section.boundarySupplementaryItems = [supplementaryItem]
        
        // MARK: - Update page control
        section.visibleItemsInvalidationHandler = { [weak self] (items, offset, env) -> Void in
            let page = round(offset.x / Constants.screenBounds.width)
            self?.posterPaginationView?.selectPage(at: Int(page))
        }
        
        return section
    }
    
    // MARK: - Data
    func registerCell(_ collectionView: UICollectionView) {
        collectionView.register(PosterCollectionViewCell.self)
    }
    
    func registerSupplementaryView(_ collectionView: UICollectionView) {
        collectionView.register(PosterPaginationView.self, supplementaryViewOfKind: PosterPaginationView.identifier)
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
        let cell =  collectionView.dequeueReusableCell(PosterCollectionViewCell.self, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let posterPaginationView = collectionView.dequeueReusableSupplementaryView(PosterPaginationView.self, ofKind: PosterPaginationView.identifier, for: indexPath)
        posterPaginationView.setNumberOfPages(self.itemsCount)
        self.posterPaginationView = posterPaginationView
        return posterPaginationView
    }
    
        
}
