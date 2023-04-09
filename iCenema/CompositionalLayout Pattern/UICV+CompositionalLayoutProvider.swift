//
//  UICollectionView+SectionType.swift
//  iCinema
//
//  Created by Ahmed Yamany on 06/02/2023.
//

import UIKit

extension UICollectionView {
    func updatecollectionViewCompositionalLayout(with provider: any CompositionalLayoutProvider) {
        provider.registerCells(for: self)
        provider.registerSupplementaryViews(for: self)
        collectionViewLayout = provider.collectionViewCompositionalLayout()
    }
}



///// Extend the UICollectionView class with methods to configure its compositional layout
///// its useful in table view with collection views as cells
//extension UICollectionView {
//
//    // A struct to hold the current compositional layout for the collection view
//    struct SectionTypeHolder {
//        static var compositionalLayout: (CompositionalLayoutableSection)?
//    }
//
//    /// A computed property to get or set the current compositional layout
//    var compositionalLayout: (CompositionalLayoutableSection)? {
//        get {
//            return SectionTypeHolder.compositionalLayout
//        }
//        set {
//            SectionTypeHolder.compositionalLayout = newValue
//        }
//    }
//
//    /// A convenience initializer to create a new collection view with a compositional layout
//    convenience init(compositionalLayout: CompositionalLayoutableSection) {
//        self.init(frame: .zero, collectionViewLayout: .init())
//        self.compositionalLayout = compositionalLayout
//        self.compositionalLayout?.delegate?.registerCell(self)
//
//        /// Set the collection view's layout to a compositional layout
//        collectionViewLayout = self.collectionViewCompositionalLayout()
//
//        /// Set the collection view's delegate and data source to the compositional layout
//        delegate = self.compositionalLayout?.delegate
//        dataSource = self.compositionalLayout?.dataSource
//    }
//
//    /// A method to create a new compositional layout for the collection view
//    func collectionViewCompositionalLayout() -> UICollectionViewLayout {
//        let layout = UICollectionViewCompositionalLayout { [ weak self]  sectionIndex, layoutEnvironment in
//            return self?.compositionalLayout?.layout?.sectionLayout()
//        }
//        return layout
//    }
//
//}
//
//
//
