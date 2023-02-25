//
//  UICollectionView+SectionType.swift
//  iCinema
//
//  Created by Ahmed Yamany on 06/02/2023.
//

import UIKit

extension UICollectionView {
    
    struct SectionTypeHolder {
        static var sectionType: (any CollectionViewSectionType)?
    }
    
    var sectionType: (any CollectionViewSectionType)? {
        get {
            return SectionTypeHolder.sectionType
        }
        set {
            SectionTypeHolder.sectionType = newValue
        }
    }
    
    convenience init(sectionType: any CollectionViewSectionType) {
        self.init(frame: .zero, collectionViewLayout: .init())
        self.sectionType = sectionType
        self.sectionType?.registerCell(self)
        
        collectionViewLayout = self.collectionViewCompositionalLayout()

        delegate = self.sectionType
        dataSource = self.sectionType
        reloadData()
    }

    func collectionViewCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [ weak self]  sectionIndex, layoutEnvironment in
            return self?.sectionType?.sectionLayout()
        }
        return layout
    }

}
