//
//  FollowingViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 07/04/2023.
//

import UIKit
import SwiftUI

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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updatNavigationBar()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.updateUI()
        
        // setup collection view compositional layout
        collectionView.updatecollectionViewCompositionalLayout(with: self)
        compositionalLayoutSections.forEach { $0.delegate?.updateItems(self.collectionView) }
        
        // setup collection view delegate and datasource with compositional layout source and delegate
        collectionView.delegate = compositionalLayoutProviderDelegate
        collectionView.dataSource = compositionalLayoutProviderDataSource

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = view.bounds
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
  
    
    // MARK: - Update UI
    //
    private func updateUI(){
        title = " Following"
        self.updateCollectionView()
    }
 
    private func updateCollectionView() {
    
        // add and clear the background of the collection view
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
                
    }
    
    private func updatNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.iCinemaYellowColor, .font: UIFont.title1]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.iCinemaYellowColor, .font: UIFont.title3]
    }
    
}


