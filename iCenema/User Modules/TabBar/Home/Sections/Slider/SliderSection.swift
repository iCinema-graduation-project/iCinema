// 
//  HeaderCollectionViewSection.swift
//  iCinema
//
//  Created by Ahmed Yamany on 27/02/2023.
//

import UIKit
import ViewAnimator
import CompositionalLayoutableSection

final class SliderCollectionViewSection: CompositionalLayoutableSection {
    // MARK: - Typealias
    //
    typealias cellType = SliderCollectionViewCell
    typealias supplementaryViewType = SliderPaginationView
    typealias ResposeType = HomeSlide
    
    var SliderPaginationView: SliderPaginationView?
    
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
extension SliderCollectionViewSection: CompositionalLayoutableSectionDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(cellType.self, for: indexPath)
                
        let zoomAnimation = AnimationType.zoom(scale: 0.2)
        cell.animate(animations: [zoomAnimation])
        cell.inject(with: self.items[indexPath.row], hostingViewController: hostingViewController)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        let SliderPaginationView = collectionView.dequeueReusableSupplementaryView(supplementaryViewType.self,
                                                                                   ofKind: supplementaryViewType.identifier,
                                                                                   for: indexPath)
        SliderPaginationView.setNumberOfPages(self.itemsCount)
        self.SliderPaginationView = SliderPaginationView
        return SliderPaginationView
        
    }
    
    func update(_ collectionView: UICollectionView, with items: [HomeSlide]) {
        self.items = items
        collectionView.reloadData()
    }
}

// MARK: - Section Layout
//
extension SliderCollectionViewSection : CompositionalLayoutableSectionLayout {
    func itemLayoutInGroup() -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        return item
    }
    
    func groupLayoutInSection() -> NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(.home.sliders.sectionHeight))
        
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
            let page = round(offset.x / CGFloat.screenBounds.width)
            self.SliderPaginationView?.selectPage(at: Int(page))
        }
        return section
        
    }
    
    // MARK: - supplementary item
    private func supplementaryItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        let supplementarySize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .absolute(.home.sliders.supplementaryHeight))
        
        return NSCollectionLayoutBoundarySupplementaryItem(layoutSize: supplementarySize,
                                                           elementKind: supplementaryViewType.identifier, alignment: .bottom)
    }

}

// MARK: - Delegate
//
extension SliderCollectionViewSection: CompositionalLayoutableSectionDelegate {
    
    func registerCell(_ collectionView: UICollectionView) {
        collectionView.register(cellType.self)
    }
    
    func registerSupplementaryView(_ collectionView: UICollectionView) {
        
        collectionView.register(supplementaryViewType.self, supplementaryViewOfKind: supplementaryViewType.identifier)
        
    }
        
}



