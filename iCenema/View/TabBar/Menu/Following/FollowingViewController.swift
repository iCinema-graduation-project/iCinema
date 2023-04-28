//
//  FollowingViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 07/04/2023.
//

import UIKit
import SwiftUI
import CompositionalLayoutableSection


final class FollowingViewController: ICinemaViewController, CompositionalLayoutProvider {
    
    // MARK: - Views
    //
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    
    // MARK: - Properties
    //
    lazy var compositionalLayoutSections: [CompositionalLayoutableSection] = [
        FollowingCollectionViewSection(hostingViewController: self),
        DummyCollectionViewSection()
    ]
    
    lazy var compositionalLayoutProviderDataSource: UICollectionViewDataSource? = CompositionalLayoutDataSource(self)
    lazy var compositionalLayoutProviderDelegate: UICollectionViewDelegate? = CompositionalLayoutDelegate(self)
    
    // MARK: - Life Cycle
    //
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.updateUI()
        
        // setup collection view compositional layout
        collectionView.updateCollectionViewCompositionalLayout(with: self)
        compositionalLayoutSections.forEach { $0.delegate?.updateItems(self.collectionView) }
        
        // setup collection view delegate and datasource with compositional layout source and delegate
        collectionView.delegate = compositionalLayoutProviderDelegate
        collectionView.dataSource = compositionalLayoutProviderDataSource

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = view.bounds
        
    }
    
    // MARK: - Update UI
    //
    private func updateUI(){
//        title = .menu.following
        navigationItem.addTitleView(title: .menu.following)
        self.updateCollectionView()
    }
 
    private func updateCollectionView() {
    
        // add and clear the background of the collection view
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
                
    }
    
    
    
}


