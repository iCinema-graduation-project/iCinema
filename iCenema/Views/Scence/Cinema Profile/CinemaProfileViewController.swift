//
//  CinemaProfileViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 04/03/2023.
//

import UIKit

class CinemaProfileViewController: ICinemaViewController {
    // MARK: - Properties
    //
    let cinema: Cinema = Cinema()
    var sections: [any CollectionViewCompositionalLayout] = [
    ]
    
    // MARK: - Views
    //
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    
    
    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.addcollectionViewCompositionalLayout(target: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
}

extension CinemaProfileViewController: CollectionViewCompositionalLayoutDataSource { }
