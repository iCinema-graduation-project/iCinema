//
//  FollowingViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 07/04/2023.
//

import UIKit


final class FollowingViewController: ICinemaViewController, CollectionViewCompositionalLayoutProvider {
    
    // MARK: - Views
    //
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    
    // MARK: - Properties
    //
    lazy var compositionalLayoutSections: [any CollectionViewCompositionalLayoutableSection] = [
        PosterCollectionViewSection(),
        DummyCollectionViewSection()
    ]
    
    lazy var providerDataSource: UICollectionViewDataSource = CompositionalLayoutDataSource(self)
    lazy var providerDelegate: UICollectionViewDelegate = CompositionalLayoutDelegate(self)
    
    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
        
        // setup collection view compositional layout
        collectionView.updatecollectionViewCompositionalLayout(with: self)
        compositionalLayoutSections.forEach { $0.hostingViewController = self }
        compositionalLayoutSections.forEach { $0.updateItems(self.collectionView) }
        
        // setup collection view delegate and datasource with compositional layout source and delegate
        collectionView.delegate = providerDelegate
        collectionView.dataSource = providerDataSource

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = view.bounds
        
    }
    
    // MARK: - Update UI
    //
    private func updateUI(){
        navigationItem.addTitleView(title: "Following")
        self.updateCollectionView()
    }
 
    private func updateCollectionView() {
        
        // add and clear the background of the collection view
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
                
    }
    
}



