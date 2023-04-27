//
//  SearchResultViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 18/04/2023.
//

import UIKit
import CompositionalLayoutableSection

final class SearchResultViewController: ICinemaViewController, CompositionalLayoutProvider {
    
    // MARK: - Views
    //
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    let segmentControl = UISegmentedControl()
    
    // MARK: - Properties
    //
    lazy var compositionalLayoutSections: [CompositionalLayoutableSection] = [
        SavedCollectionViewSection(hostingViewController: self),
        DummyCollectionViewSection()
    ]
    
    lazy var compositionalLayoutProviderDataSource: UICollectionViewDataSource? = CompositionalLayoutDataSource(self)
    lazy var compositionalLayoutProviderDelegate: UICollectionViewDelegate? = CompositionalLayoutDelegate(self)
    
    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()

        segmentControl.insertSegment(withTitle: "Position", at: 0, animated: true)
        segmentControl.insertSegment(withTitle: "Price", at: 1, animated: true)
        segmentControl.selectedSegmentIndex = 0
       
        collectionView.reloadData()

    }
 
    // MARK: - Update UI
    //
    private func updateUI(){
        self.updateSegmentControll()
        self.updateCollectionView()
        self.updatecollectionViewCompositionalLayout()
    }
    
    private func updateSegmentControll() {
        view.addSubview(segmentControl)
        segmentControl.fillXSuperViewConstraints(paddingLeft: .view.padding.left, paddingRight: .view.padding.right)
        segmentControl.makeConstraints(topAnchor: view.safeAreaLayoutGuide.topAnchor)
    }
    
    private func updateCollectionView() {
    
        // add and clear the background of the collection view
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        
        collectionView.fillXSuperViewConstraints()
        collectionView.makeConstraints(topAnchor: segmentControl.bottomAnchor,
                                       bottomAnchor: view.bottomAnchor,
                                       padding: UIEdgeInsets(top: 8, left: 0,
                                                             bottom: 0, right: 0))
    }
    
    private func updatecollectionViewCompositionalLayout() {
        // setup collection view compositional layout
        collectionView.updatecollectionViewCompositionalLayout(with: self)
        compositionalLayoutSections.forEach { $0.delegate?.updateItems(self.collectionView) }
        
        // setup collection view delegate and datasource with compositional layout source and delegate
        collectionView.delegate = compositionalLayoutProviderDelegate
        collectionView.dataSource = compositionalLayoutProviderDataSource
    }
    
    
}
