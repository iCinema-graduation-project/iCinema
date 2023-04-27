//
//  CinemasSection.swift
//  iCinema
//
//  Created by Ahmed Yamany on 01/03/2023.
//

import UIKit
import SwiftUI
import ViewAnimator
import CompositionalLayoutableSection


final class CinemaCollectionViewSection: CompositionalLayoutableSection {
    // MARK: - Typealias
    //
    typealias ResposeType = Cinema
    typealias cellType = CinemaCell
    typealias supplementaryViewType = MovieSectionHeader
    
    // MARK: - Properties
    //
    var items: [ResposeType] = [] { didSet { itemsCount = items.count } }
    var itemsCount: Int = 0
    
    var hostingViewController: UIViewController?
    init(hostingViewController: UIViewController) {
        
        super.init()
        self.hostingViewController = hostingViewController
        dataSource = self
        layout = self
        delegate = self
    
    }
    
}
    
// MARK: - Section Layout
//
extension CinemaCollectionViewSection : CompositionalLayoutableSectionLayout {
    
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
        
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: .cell.padding.left,
                                                      bottom: 0, trailing: .cell.padding.right)
        
        return group
        
    }
    
    func sectionLayout() -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: self.groupLayoutInSection())
        
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: .cell.padding.left, bottom: 0, trailing: 0)
        
        // MARK: - add supplementary view
        
        section.boundarySupplementaryItems = [self.supplementaryItem()]
        
        return section
    }
    
    private func supplementaryItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        
        let supplementarySize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .absolute(.supplementaryHeight))
        
        return  NSCollectionLayoutBoundarySupplementaryItem(layoutSize: supplementarySize,
                                                                            elementKind: supplementaryViewType.identifier,
                                                                            alignment: .top)
    }
    
}

// MARK: - Data Source
//
extension CinemaCollectionViewSection: CompositionalLayoutableSectionDataSource {
    
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
    
}

// MARK: - Delegate
//
extension CinemaCollectionViewSection: CompositionalLayoutableSectionDelegate {
    
    func registerCell(_ collectionView: UICollectionView) {
        collectionView.register(cellType.self)
    }
    
    func registerSupplementaryView(_ collectionView: UICollectionView) {
        collectionView.register(supplementaryViewType.self, supplementaryViewOfKind: supplementaryViewType.identifier)
    }
    
    func updateItems(_ collectionView: UICollectionView) {
        // make network request here
        DispatchQueue.main.async { [ unowned self ] in
            
            self.items = [
                Cinema(name: "Galaxy", followersCount: 12, rate: 3.5, ChairsCount: 200, followed: false),
                Cinema(name: "Galaxy", followersCount: 12, rate: 3.5, ChairsCount: 200, followed: false),
                Cinema(name: "Galaxy", followersCount: 12, rate: 3.5, ChairsCount: 200, followed: false),
                Cinema(name: "Galaxy", followersCount: 12, rate: 3.5, ChairsCount: 200, followed: false),
                Cinema(name: "Galaxy", followersCount: 12, rate: 3.5, ChairsCount: 200, followed: false),
            ]
            collectionView.reloadData()
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let hostingViewController = hostingViewController as? ViewController else { return }

        let cinemaProfileVC = CinemaProfileViewController()

        let cinema: Cinema = Cinema(name: "Galaxy", followersCount: 63, rate: 3.5,
                                    ChairsCount: 430, followed: false)

        cinemaProfileVC.viewModel = .init(cinema: cinema)
        hostingViewController.presentViewController(cinemaProfileVC)
    }
    
}
