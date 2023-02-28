//
//  UICollectionView+register.swift
//  Book Nexus
//
//  Created by Ahmed Yamany on 19/01/2023.
//

import UIKit

/// Extend the UICollectionView class with two helper methods
extension UICollectionView {
    /// Register a cell class with the collection view and associate it with a reuse identifier
    func register<T: UICollectionViewCell>(_ class: T.Type) where T: IdentifiableView {
        register(T.self, forCellWithReuseIdentifier: T.identifier)
    }
    
    /// Dequeue a reusable cell of a specified class from the collection view
    func dequeueReusableCell<T: UICollectionViewCell>(_ class: T.Type, for indexPath: IndexPath) -> T where T: IdentifiableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError(
                "Couldn't find UICollectionViewCell for \(T.identifier), make sure the cell is registered with collection view")
        }
        return cell
    }
    
}
