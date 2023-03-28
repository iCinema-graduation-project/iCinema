//
//  CinemasSection.swift
//  iCinema
//
//  Created by Ahmed Yamany on 01/03/2023.
//

import UIKit
import SwiftUI
import ViewAnimator

final class CinemaCollectionViewSection: NSObject, CollectionViewCompositionalLayout {
    // MARK: - Typealias
    //
    typealias ResposeType = String
    typealias cellType = CinemaCell
    typealias supplementaryViewType = MovieSectionHeader
    
    // MARK: - Properties
    //
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
    //
    func itemLayoutInGroup() -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        return item
    }
    
    func groupLayoutInSection() -> NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(.home.cinemas.size.width),
                                               heightDimension: .absolute(.home.cinemas.size.height))
        
        let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                                                subitems: [self.itemLayoutInGroup()])
        
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: .cell.padding.left, bottom: 0, trailing: .cell.padding.right)
        
        return group
    }
    
    func sectionLayout() -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: self.groupLayoutInSection())
        
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: .cell.padding.left, bottom: 0, trailing: 0)
        
        // MARK: - add supplementary view
        let supplementarySize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .absolute(.supplementaryHeight))
        
        let supplementaryItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: supplementarySize,
                                                                            elementKind: supplementaryViewType.identifier,
                                                                            alignment: .top)
        
        section.boundarySupplementaryItems = [supplementaryItem]
        
        return section
    }
    
    // MARK: - Data
    //
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
    //
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cellType.self, for: indexPath)
        
        let fromAnimation = AnimationType.from(direction: .right, offset: 50.0)
        cell.animate(animations: [fromAnimation])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let supView = collectionView.dequeueReusableSupplementaryView(supplementaryViewType.self,
                                                                      ofKind: supplementaryViewType.identifier,
                                                                      for: indexPath)
        supView.setTitle(.cinemas)
        return supView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cinemaProfileVC = CinemaProfileViewController()
        cinemaProfileVC.setup(cinema: nil)
        self.target.presentViewController(cinemaProfileVC)
    }
    
}
    
    

