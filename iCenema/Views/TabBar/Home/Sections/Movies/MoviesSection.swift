//
//  MoviesSection.swift
//  iCinema
//
//  Created by Ahmed Yamany on 28/02/2023.
//

import UIKit
import ViewAnimator

final class MoviesCollectionViewSection: CompositionalLayoutableSection {

    // MARK: - Typealias
    //
    typealias ResposeType = Movie
    typealias cellType = MovieCell
    typealias supplementaryViewType = MovieSectionHeader
    
    // MARK: - Properties
    //
    var items: [ResposeType] = [] { didSet { itemsCount = items.count } }
    var itemsCount: Int = 0
    
    var hostingViewController: UIViewController? = nil
    init(hostingViewController: UIViewController) {
        
        super.init()
        self.hostingViewController = hostingViewController
        dataSource = self
        layout = self
        delegate = self
    
    }

    
}

// MARK: - Data Source
//
extension MoviesCollectionViewSection: CompositionalLayoutableSectionDataSource {
    
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
        
        let supplementaryView = collectionView.dequeueReusableSupplementaryView(supplementaryViewType.self,
                                                                                ofKind: supplementaryViewType.identifier,
                                                                                for: indexPath)
        supplementaryView.setTitle(.home.forYou)
        
        return supplementaryView
    }
    
    
}

// MARK: - Section Layout
//
extension MoviesCollectionViewSection : CompositionalLayoutableSectionLayout {
    
    func itemLayoutInGroup() -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        
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
        section.contentInsets = NSDirectionalEdgeInsets(top: .cell.padding.top, leading: .cell.padding.right
                                                        , bottom: .cell.padding.bottom, trailing: .cell.padding.right)
        
        section.boundarySupplementaryItems = [self.supplementaryItem()]

        return section
        
    }
    
    // MARK: -  supplementary Item
    private func supplementaryItem() -> NSCollectionLayoutBoundarySupplementaryItem{
        
        let supplementarySize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .absolute(.supplementaryHeight))
        return NSCollectionLayoutBoundarySupplementaryItem(layoutSize: supplementarySize,
                                                                            elementKind: supplementaryViewType.identifier,
                                                                            alignment: .top)
    
    }
}

// MARK: - Delegate
extension MoviesCollectionViewSection: CompositionalLayoutableSectionDelegate {
    
    func registerCell(_ collectionView: UICollectionView) {
        collectionView.register(cellType.self)
    }
    
    func registerSupplementaryView(_ collectionView: UICollectionView) {
        
        collectionView.register(supplementaryViewType.self, supplementaryViewOfKind: supplementaryViewType.identifier)
        
    }
        
    func updateItems(_ collectionView: UICollectionView) {
        DispatchQueue.main.async { [ unowned self ] in
            
            self.items = [
                Movie(poster: "", name: "Avatar", bookmarket: false),
                Movie(poster: "", name: "spider man", bookmarket: true),
                Movie(poster: "", name: "pat man", bookmarket: false),
                Movie(poster: "", name: "super man", bookmarket: false)
            ]
            
            collectionView.reloadData()
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let hostingViewController = hostingViewController as? ViewController else { return }
        let mv = MovieProfileViewController()
        mv.viewModel = .init(movie: self.items[indexPath.item])
        hostingViewController.presentViewController(mv)
        
    }

}


