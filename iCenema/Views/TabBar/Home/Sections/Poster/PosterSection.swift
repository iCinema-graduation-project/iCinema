// 
//  HeaderCollectionViewSection.swift
//  iCinema
//
//  Created by Ahmed Yamany on 27/02/2023.
//

import UIKit
import ViewAnimator

final class PosterCollectionViewSection: NSObject, CollectionViewCompositionalLayout {
    typealias ResposeType = String
    typealias cellType = PosterCollectionViewCell
    typealias supplementaryViewType = PosterPaginationView
    
    // MARK: - Properties
    var posterPaginationView: PosterPaginationView?
    
    var items: [ResposeType] = [] {
        didSet {
            itemsCount = items.count
        }
    }
    
    var itemsCount: Int = 0
    var target: ViewController
    
    // MARK: - initalizer
    //
    init(target: ViewController) {
        self.target = target
    }
    
    // MARK: - Section Layout
    func itemLayoutInGroup() -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        return item
    }
    
    func groupLayoutInSection() -> NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(.home.posters.sectionHeight))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [self.itemLayoutInGroup()])
        return group
    }
    
    func sectionLayout() -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: self.groupLayoutInSection())
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        // MARK: - add supplementary view
        let supplementarySize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(.home.posters.supplementaryHeight))
        let supplementaryItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: supplementarySize, elementKind: supplementaryViewType.identifier, alignment: .bottom)
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
        collectionView.register(cellType.self)
    }
    
    func registerSupplementaryView(_ collectionView: UICollectionView) {
        collectionView.register(supplementaryViewType.self, supplementaryViewOfKind: supplementaryViewType.identifier)
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
        let cell =  collectionView.dequeueReusableCell(cellType.self, for: indexPath)
                
        let zoomAnimation = AnimationType.zoom(scale: 0.2)
        cell.animate(animations: [zoomAnimation])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let posterPaginationView = collectionView.dequeueReusableSupplementaryView(supplementaryViewType.self, ofKind: supplementaryViewType.identifier, for: indexPath)
        posterPaginationView.setNumberOfPages(self.itemsCount)
        self.posterPaginationView = posterPaginationView
        return posterPaginationView
    }
    
}
