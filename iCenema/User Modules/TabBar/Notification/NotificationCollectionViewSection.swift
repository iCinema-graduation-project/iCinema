//
//  NotificationCollectionViewSection.swift
//  iCinema
//
//  Created by Ahmed Yamany on 13/06/2023.
//



import UIKit
import ViewAnimator
import CompositionalLayoutableSection


final class NotificationCollectionViewSection: CompositionalLayoutableSection {

    // MARK: - Typealias
    //
    typealias ResposeType = NotificationModel
    typealias cellType = NotificationCell
    
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
extension NotificationCollectionViewSection: CompositionalLayoutableSectionDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cellType.self, for: indexPath)
        let fromAnimation = AnimationType.from(direction: .bottom, offset: 50.0)
        cell.animate(animations: [fromAnimation])
        cell.update(with: self.items[indexPath.row])
        return cell
    }
    func update(_ collectionView: UICollectionView, with items: [ResposeType]) {
        self.items = items
        collectionView.reloadData()
    }
}

// MARK: - Section Layout
//
extension NotificationCollectionViewSection : CompositionalLayoutableSectionLayout {
    func itemLayoutInGroup() -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        return item
    }
    func groupLayoutInSection() -> NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(96))
        let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                                                subitems: [self.itemLayoutInGroup()])
        group.contentInsets = NSDirectionalEdgeInsets(top: 24, leading: 0,
                                                      bottom: 0, trailing: 0)
        return group
    }
    func sectionLayout() -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: self.groupLayoutInSection())
//        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 12,
                                                        leading: 22,
                                                        bottom: 22,
                                                        trailing: 22)
        return section
    }
}

// MARK: - Delegate
extension NotificationCollectionViewSection: CompositionalLayoutableSectionDelegate {
    func registerCell(_ collectionView: UICollectionView) {
        collectionView.register(cellType.self)
    }
}



