//
//  SaveedCollectinViewSection.swift
//  iCinema
//
//  Created by Ahmed Yamany on 12/04/2023.
//

import UIKit
import ViewAnimator
import CompositionalLayoutableSection

final class SavedCollectionViewSection: CompositionalLayoutableSection {
    typealias CellType = MovieCell

    var hostingViewController: UIViewController?
    init(hostingViewController: UIViewController) {
       
        super.init()
        self.hostingViewController = hostingViewController
        dataSource = self
        delegate = self
        layout = self
    }
    
}

// MARK: - DataSource
//
extension SavedCollectionViewSection: CompositionalLayoutableSectionDataSource {
    
    struct ItemsHolder {
        static var itemsHolder: [ResposeType] = []
        static var itemsCount: Int = 0
    }
    
    typealias ResposeType = Movie
    var items: [ResposeType] {
        get {
            return ItemsHolder.itemsHolder
        }
        set {
            ItemsHolder.itemsHolder = newValue
            itemsCount = items.count
        }
    }
    var itemsCount: Int {
        get {
            return ItemsHolder.itemsCount
        }
        set {
            ItemsHolder.itemsCount = newValue
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(CellType.self, for: indexPath)
        
        let animator = AnimationType.from(direction: .bottom, offset: 100)
        cell.animate(animations: [animator], delay: 0.0 , duration: 0.5)
        
        return cell
    }
    
    
}

// MARK: - Layout
//
extension SavedCollectionViewSection: CompositionalLayoutableSectionLayout {
    func itemLayoutInGroup() -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let padding = (Constants.screenBounds.width - (CGFloat.home.movies.size.width * 2)) / 3

        item.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                     leading: padding,
                                                     bottom: 0,
                                                     trailing: padding)
        return item
    }
    
    func groupLayoutInSection() -> NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(.home.movies.size.height + 20))
        let group: NSCollectionLayoutGroup
        
        if #available(iOS 16.0, *) {
            group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: self.itemLayoutInGroup(), count: 2)
        } else {
            group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: self.itemLayoutInGroup(), count: 2)
        }
        
        
        group.contentInsets = NSDirectionalEdgeInsets(top: .cell.padding.top,
                                                      leading: 0,
                                                      bottom: .cell.padding.bottom,
                                                      trailing: 0)

        return group
    }
    
    func sectionLayout() -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: self.groupLayoutInSection())
        return section
    }
    
    
}


// MARK: - Delegate
//
extension SavedCollectionViewSection: CompositionalLayoutableSectionDelegate {
    func registerCell(_ collectionView: UICollectionView) {
        collectionView.register(CellType.self)
    }
    
    func updateItems(_ collectionView: UICollectionView) {
        DispatchQueue.main.async { [ unowned self ] in
            self.items = [
                Movie(poster: "", name: "Avatar", bookmarket: false),
                Movie(poster: "", name: "spider man", bookmarket: true),
                Movie(poster: "", name: "pat man", bookmarket: false),
                Movie(poster: "", name: "super man", bookmarket: false),
                Movie(poster: "", name: "pat man", bookmarket: false),
                Movie(poster: "", name: "super man", bookmarket: false),
                Movie(poster: "", name: "pat man", bookmarket: false),
                Movie(poster: "", name: "super man", bookmarket: false),
                Movie(poster: "", name: "pat man", bookmarket: false),
                Movie(poster: "", name: "super man", bookmarket: false)
            ]
            collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let hostingViewController = hostingViewController as? ICinemaViewController else { return }
        let mv = MovieProfileViewController()
        mv.viewModel = .init(movie: self.items[indexPath.item])
        hostingViewController.presentViewController(mv)
        
    }
    
}
