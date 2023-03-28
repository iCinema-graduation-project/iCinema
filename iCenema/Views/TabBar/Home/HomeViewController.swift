//
//  HomeViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 24/02/2023.
//

import UIKit
import SwiftUI

final class HomeViewController: ICinemaViewController, CollectionViewCompositionalLayoutDataSource {
    
    // MARK: - Properties
    lazy var sections: [any CollectionViewCompositionalLayout] = [
        PosterCollectionViewSection(target: self),
        MoviesCollectionViewSection(target: self),
        CinemaCollectionViewSection(target: self),
        MoviesCollectionViewSection(target: self),
        
        DummyCollectionViewSection(target: self)
    ]
    
    // MARK: - Views
    //
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())

    
    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
        collectionView.addcollectionViewCompositionalLayout(target: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        iCinemaTabBar.show()
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
                                                            style: .plain, target: self, action: nil)
    }
    
    private func addUserProfileImageToLeftBarButtonItem(){
        let imageView = UIImageView(image: UIImage(named: "profile")).makeCircleImage(withWidth: .profile.imageSize.width)
        imageView.layer.borderColor = UIColor.iCinemaYellowColor.cgColor
        imageView.layer.borderWidth = 1.5
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imageView)
    }
    
    private func addCollectionView() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        
        // FIXME: - home sections get items
        self.sections.forEach { $0.getItems(self.collectionView) }
    }
    
}

// MARK: - CollectionViewDataSource
//
extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.sections.count
    }
    
    // FIXME: - items count
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let compositionalSection = getSection(at: IndexPath(item: 0, section: section))
        return compositionalSection.itemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = self.getSection(at: indexPath)
        return section.collectionView(collectionView, cellForItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = self.getSection(at: indexPath)
        return section.collectionView?(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath) ?? UICollectionReusableView()
    }
    
}


// MARK: - CollectionViewDelegate
//
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = getSection(at: indexPath)
        section.collectionView?(collectionView, didSelectItemAt: indexPath)
    }
}
