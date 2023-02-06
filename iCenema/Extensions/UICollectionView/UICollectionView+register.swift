//
//  UICollectionView+register.swift
//  Book Nexus
//
//  Created by Ahmed Yamany on 19/01/2023.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(cell name: T.Type) {
        register(T.self, forCellWithReuseIdentifier: name.identifier)
    }

}
