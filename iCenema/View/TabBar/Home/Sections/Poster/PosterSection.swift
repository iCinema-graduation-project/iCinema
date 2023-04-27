// 
//  HeaderCollectionViewSection.swift
//  iCinema
//
//  Created by Ahmed Yamany on 27/02/2023.
//

import UIKit
import ViewAnimator
import CompositionalLayoutableSection

final class PosterCollectionViewSection: CompositionalLayoutableSection {
    // MARK: - Typealias
    //
    typealias cellType = PosterCollectionViewCell
    typealias supplementaryViewType = PosterPaginationView
    typealias ResposeType = Poster

    
    var posterPaginationView: PosterPaginationView?
    
    var hostingViewController: ICinemaViewController

    init(hostingViewController: ICinemaViewController) {
        self.hostingViewController = hostingViewController
        super.init()
        
        dataSource = self
        layout = self
        delegate = self
        
    }
    
    var items: [ResposeType] = [] { didSet { itemsCount = items.count } }
    var itemsCount: Int = 0
        
}

// MARK: - Data Source
//
extension PosterCollectionViewSection: CompositionalLayoutableSectionDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(cellType.self, for: indexPath)
                
        let zoomAnimation = AnimationType.zoom(scale: 0.2)
        cell.animate(animations: [zoomAnimation])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        let posterPaginationView = collectionView.dequeueReusableSupplementaryView(supplementaryViewType.self,
                                                                                   ofKind: supplementaryViewType.identifier,
                                                                                   for: indexPath)
        posterPaginationView.setNumberOfPages(self.itemsCount)
        self.posterPaginationView = posterPaginationView
        return posterPaginationView
        
    }
}

// MARK: - Section Layout
//
extension PosterCollectionViewSection : CompositionalLayoutableSectionLayout {
    func itemLayoutInGroup() -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        return item
    }
    
    func groupLayoutInSection() -> NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(.home.posters.sectionHeight))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [self.itemLayoutInGroup()])
        return group
    }
    
    func sectionLayout() -> NSCollectionLayoutSection {
        
        let section = NSCollectionLayoutSection(group: self.groupLayoutInSection())
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        // add supplementary item
        section.boundarySupplementaryItems = [self.supplementaryItem()]
        
        // MARK: - Update page control
        section.visibleItemsInvalidationHandler = { [unowned self] (items, offset, env) -> Void in
            let page = round(offset.x / Constants.screenBounds.width)
            self.posterPaginationView?.selectPage(at: Int(page))
        }
        return section
        
    }
    
    // MARK: - supplementary item
    private func supplementaryItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        let supplementarySize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .absolute(.home.posters.supplementaryHeight))
        
        return NSCollectionLayoutBoundarySupplementaryItem(layoutSize: supplementarySize,
                                                           elementKind: supplementaryViewType.identifier, alignment: .bottom)
    }

}

// MARK: - Delegate
//
extension PosterCollectionViewSection: CompositionalLayoutableSectionDelegate {
    
    func registerCell(_ collectionView: UICollectionView) {
        collectionView.register(cellType.self)
    }
    
    func registerSupplementaryView(_ collectionView: UICollectionView) {
        
        collectionView.register(supplementaryViewType.self, supplementaryViewOfKind: supplementaryViewType.identifier)
        
    }
        
    func updateItems(_ collectionView: UICollectionView) {
        
        // make a network request here
        DispatchQueue.main.async { [ unowned self ]  in
            
            self.items = [
                Poster(),
                Poster(),
                Poster(),
                Poster(),
                Poster(),
            ]
            
            collectionView.reloadData()

        }

    }

}



