//
//  MoviesSection.swift
//  iCinema
//
//  Created by Ahmed Yamany on 28/02/2023.
//

import UIKit
import ViewAnimator

final class MoviesCollectionViewSection: NSObject, CollectionViewCompositionalLayoutableSection {
    // MARK: - Typealias
    //
    typealias ResposeType = String
    typealias cellType = MovieCell
    typealias supplementaryViewType = MovieSectionHeader
    
    // MARK: - Properties
    //
    var items: [ResposeType] = [] {
        didSet {
            itemsCount = items.count
        }
    }
    
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
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(.home.movies.size.width),
                                               heightDimension: .absolute(.home.movies.size.height))
        
        let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                                                subitems: [self.itemLayoutInGroup()])
        
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: .cell.padding.left,
                                                      bottom: 0, trailing: .cell.padding.right)
        return group
    }
    
    func sectionLayout() -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: self.groupLayoutInSection())
        
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: .cell.padding.top,
                                                        leading: .cell.padding.right,
                                                        bottom: .cell.padding.bottom,
                                                        trailing: .cell.padding.right)
        
        
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
        
    func updateItems(_ collectionView: UICollectionView) {
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
        let supplementaryView = collectionView.dequeueReusableSupplementaryView(supplementaryViewType.self, ofKind: supplementaryViewType.identifier, for: indexPath)
        supplementaryView.setTitle(.home.forYou)
        
        return supplementaryView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let hostingViewController = hostingViewController as? ViewController else { return }
        let mv = MovieProfileViewController()
        mv.setup(movie: nil)
        hostingViewController.presentViewController(mv)
    }
    
    
    
}
