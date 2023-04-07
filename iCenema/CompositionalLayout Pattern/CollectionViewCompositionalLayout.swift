//
//  CollectionViewModelSectionType.swift
//  iCinema
//
//  Created by Ahmed Yamany on 05/02/2023.
//

import UIKit

/// This protocol defines a set of methods and properties that a section in the compositional layout should implement
/// Using this protocol can lead to better organization and abstraction of your code,
/// as well as making it easier to reuse and maintain.
/// You can create multiple objects conforming to this protocol
/// and switch between them to show different sections in the same collection view,
///
protocol CollectionViewCompositionalLayoutableSection: AnyObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    /// A generic type representing the data type for the items in the section.
    associatedtype ResposeType
    
    /// An array of items for the section.
    var items: [ResposeType] { get set }
    
    /// Items count in the section.
    /// Why not using items.count?
    /// because XCode gives me error build failed with a nonzero exit code so this was the solve to ignore this bug
    var itemsCount: Int { get set }
    
    /// A reference to the ViewController that is managing the UICollectionView.
    var hostingViewController: UIViewController? { get set }
    
    /// Returns the layout for an item in the section.
    func itemLayoutInGroup() -> NSCollectionLayoutItem
    
    /// Returns the layout for the group of items in the section.
    func groupLayoutInSection() -> NSCollectionLayoutGroup
    
    /// Returns the layout for the section.
    func sectionLayout() -> NSCollectionLayoutSection
    
    /// Registers the cell type to be used for the items in the section.
    func registerCell(_ collectionView: UICollectionView)
    
    /// Registers the supplementary view type to be used in the section.
    func registerSupplementaryView(_ collectionView: UICollectionView)
    
    /// updates items and should reloads collection view data 
    func updateItems(_ collectionView: UICollectionView)
}


// Define the behavior of The Collection View as a cell in table View
protocol CollectionViewCompositionalLayoutForTableView: CollectionViewCompositionalLayoutProvider {
    func numberOfSections(in tableView: UITableView) -> Int
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
}

