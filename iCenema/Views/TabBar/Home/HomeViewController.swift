//
//  HomeViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 24/02/2023.
//

import UIKit
import SwiftUI

/// Confirms UICollectionViewCompositionalLayoutDataSource
/// To define the behavior and strucure of the collection view 
final class HomeViewController: ICinemaViewController, CollectionViewCompositionalLayoutProvider {

    // MARK: - Views
    //
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    
    // MARK: - Properties
    //
    var compositionalLayoutSections: [any CollectionViewCompositionalLayoutableSection] = [
        PosterCollectionViewSection(),
        MoviesCollectionViewSection(),
        CinemaCollectionViewSection(),
        MoviesCollectionViewSection(),
        DummyCollectionViewSection()
    ]
    
    lazy var providerDataSource: UICollectionViewDataSource = CompositionalLayoutDataSource(self)
    lazy var providerDelegate: UICollectionViewDelegate = CompositionalLayoutDelegate(self)
    
    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
        
        collectionView.updatecollectionViewCompositionalLayout(with: self)
        compositionalLayoutSections.forEach { $0.hostingViewController = self }
        self.compositionalLayoutSections.forEach { $0.updateItems(self.collectionView) }

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TabBarViewModel.shared.show()
    }
    
    // MARK: - Update UI
    private func updateUI(){
        navigationItem.addTitleView(title: "ICinema")
        self.addMagnifyingGlassToRightBarButtonItem()
        self.addUserProfileImageToLeftBarButtonItem()
        self.addCollectionView()
    }
    
    private func addMagnifyingGlassToRightBarButtonItem(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"),
                                                            style: .plain,
                                                            target: self,
                                                            action: nil)
    }
    
    private func addUserProfileImageToLeftBarButtonItem(){
        
        let imageView = UIImageView(image: UIImage(named: "profile"))
                                            .makeCircleImage(withWidth: .profile.imageSize.width)
        
        imageView.layer.borderColor = UIColor.iCinemaYellowColor.cgColor
        
        imageView.layer.borderWidth = 1.5
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imageView)
        
    }
    
    private func addCollectionView() {
        
        view.addSubview(collectionView)
        collectionView.delegate = providerDelegate
        collectionView.dataSource = providerDataSource
        collectionView.backgroundColor = .clear
        
    }
    
}

