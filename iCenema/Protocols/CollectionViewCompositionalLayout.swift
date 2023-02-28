//
//  CollectionViewModelSectionType.swift
//  iCinema
//
//  Created by Ahmed Yamany on 05/02/2023.
//

import UIKit

/// This Protocol defines the behavior and structure of sections in a UICollectionView.
/// Using this protocol can lead to better organization and abstraction of your code,
/// as well as making it easier to reuse and maintain.
/// You can create multiple objects conforming to this protocol
/// and switch between them to show different sections in the same collection view,
///
protocol CollectionViewCompositionalLayout: AnyObject, UICollectionViewDelegate, UICollectionViewDataSource {
    associatedtype ResposeType
    var items: [ResposeType] { get }
    func itemLayoutInGroup() -> NSCollectionLayoutItem
    func groupLayoutInSection() -> NSCollectionLayoutGroup
    func sectionLayout() -> NSCollectionLayoutSection
    func registerCell(_ collectionView: UICollectionView)
    func getItems(_ collectionView: UICollectionView)
}


/// Defines the behavior of collectionView sections
protocol CollectionViewCompositionalLayoutDataSource {
    var sections: [any CollectionViewCompositionalLayout] { get set }
}

extension CollectionViewCompositionalLayoutDataSource {
    
    func registerCells(_ collectionView: UICollectionView) {
        sections.forEach { $0.registerCell(collectionView) }
    }
    
    func getSection(at indexPath: IndexPath) -> any CollectionViewCompositionalLayout {
        return self.sections[indexPath.section]
    }
    
      func collectionViewCompositionalLayout() -> UICollectionViewLayout {
          let layout = UICollectionViewCompositionalLayout { [self]  sectionIndex, layoutEnvironment in
              return self.getSection(at: IndexPath(row: 0, section: sectionIndex)).sectionLayout()
          }
          return layout
      }
}

// Define the behavior of The Collection View as a cell in table View
protocol CollectionViewCompositionalLayoutForTableView: CollectionViewCompositionalLayoutDataSource {
    func numberOfSections(in tableView: UITableView) -> Int
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
}

