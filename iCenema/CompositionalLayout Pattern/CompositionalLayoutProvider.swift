//
//  UICollectionViewCompositionalLayoutProvider.swift
//  iCinema
//
//  Created by Ahmed Yamany on 07/04/2023.
//

import UIKit

/// Protocol that defines the requirements for providing data for a compositional layout in a collection view
protocol CompositionalLayoutProvider {
    
    /// An array of compositional layout sections to be used in the collection view's layout
    var compositionalLayoutSections: [CompositionalLayoutableSection] { get set }
    
    /// data source and delegate to be used by the collection view
    var compositionalLayoutProviderDataSource: UICollectionViewDataSource? { get }
    var compositionalLayoutProviderDelegate: UICollectionViewDelegate? { get }
    
}

extension CompositionalLayoutProvider {
    
    /// Registers cells for all sections in the collection view
    func registerCells(for collectionView: UICollectionView) {
        compositionalLayoutSections.forEach { $0.delegate?.registerCell(collectionView) }
    }
    
    /// Registers supplementary views for all sections in the collection view
    func registerSupplementaryViews(for collectionView: UICollectionView) {
        compositionalLayoutSections.forEach { $0.delegate?.registerSupplementaryView?(collectionView) }
    }
    
    /// Retrieves the section at the given index path
    func getSection(at indexPath: IndexPath) -> CompositionalLayoutableSection {
        return self.compositionalLayoutSections[indexPath.section]
    }
    
    /// Constructs and returns a UICollectionViewCompositionalLayout instance based on the compositional layout sections
    func collectionViewCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
      let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
          
          return self.getSection(at: IndexPath(row: 0, section: sectionIndex)).layout?.sectionLayout()
          
      }
      return layout
        
    }
}

