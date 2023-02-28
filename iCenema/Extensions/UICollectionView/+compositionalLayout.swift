//
//  UICollectionView+SectionType.swift
//  iCinema
//
//  Created by Ahmed Yamany on 06/02/2023.
//

import UIKit

/// Extend the UICollectionView class with methods to configure its compositional layout
extension UICollectionView {
    
    // A struct to hold the current compositional layout for the collection view
    struct SectionTypeHolder {
        static var compositionalLayout: (any CollectionViewCompositionalLayout)?
    }
    
    /// A computed property to get or set the current compositional layout
    var compositionalLayout: (any CollectionViewCompositionalLayout)? {
        get {
            return SectionTypeHolder.compositionalLayout
        }
        set {
            SectionTypeHolder.compositionalLayout = newValue
        }
    }
    
    /// A convenience initializer to create a new collection view with a compositional layout
    convenience init(compositionalLayout: any CollectionViewCompositionalLayout) {
        self.init(frame: .zero, collectionViewLayout: .init())
        self.compositionalLayout = compositionalLayout
        self.compositionalLayout?.registerCell(self)
        
        /// Set the collection view's layout to a compositional layout
        collectionViewLayout = self.collectionViewCompositionalLayout()

        /// Set the collection view's delegate and data source to the compositional layout
        delegate = self.compositionalLayout
        dataSource = self.compositionalLayout
    }

    /// A method to create a new compositional layout for the collection view
    func collectionViewCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [ weak self]  sectionIndex, layoutEnvironment in
            return self?.compositionalLayout?.sectionLayout()
        }
        return layout
    }

}


extension UICollectionView: CollectionViewCompositionalLayoutDataSource {
    
    // A struct to hold the current compositional layout for the collection view
    struct SectionsHolder {
        static var sections: [any CollectionViewCompositionalLayout] = []
    }
    
    /// A computed property to get or set the current sections of compositional layout
    var sections: [any CollectionViewCompositionalLayout] {
        get {
            return SectionsHolder.sections
        }
        set {
            SectionsHolder.sections = newValue
        }
    }
    
    /// A convenience initializer to create a new collection view with a compositional layout
    convenience init(sections: [any CollectionViewCompositionalLayout]) {
        self.init(frame: .zero, collectionViewLayout: .init())
        self.sections = sections
            
        self.registerCells(self)
        self.registerSupplementaryViews(self)
        collectionViewLayout = collectionViewCompositionalLayoutForSections()
    }

   

}

