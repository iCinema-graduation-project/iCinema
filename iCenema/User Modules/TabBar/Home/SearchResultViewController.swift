//
//  SearchResultViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 18/04/2023.
//

import UIKit
import CompositionalLayoutableSection
import MakeConstraints

final class SearchResultViewController: ICinemaViewController, CompositionalLayoutProvider {
    
    // MARK: - Views
    //
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    let segmentControl = UISegmentedControl()
    
    // MARK: - Properties
    //
    lazy var compositionalLayoutSections: [CompositionalLayoutableSection] = []
    lazy var compositionalLayoutProviderDataSource: UICollectionViewDataSource? = CompositionalLayoutDataSource(self)
    lazy var compositionalLayoutProviderDelegate: UICollectionViewDelegate? = CompositionalLayoutDelegate(self)
    
    var network: NetworkLayer<SearchModel> = .init(endpoint: "search", method: .get)
    
    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
        segmentControl.insertSegment(withTitle: "Position", at: 0, animated: true)
        segmentControl.insertSegment(withTitle: "Price", at: 1, animated: true)
        segmentControl.selectedSegmentIndex = 0
        collectionView.reloadData()
        
        segmentControl.addTarget(self, action: #selector(self.segmentControlValueChanged), for: .valueChanged)
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
        // setup collection view delegate and datasource with compositional layout source and delegate
        collectionView.delegate = compositionalLayoutProviderDelegate
        collectionView.dataSource = compositionalLayoutProviderDataSource
        
        // setup collection view compositional layout
        collectionView.updateCollectionViewCompositionalLayout(with: self)
    }
    public func updateSearch(with query: String) {
        self.network.networkRequest.update(parameters: ["search": query])
        network.request { [self] response in
            if let value = response.value {
                let section = SavedCollectionViewSection(hostingViewController: self)
                self.compositionalLayoutSections.append(section)
//                self.compositionalLayoutSections.append(DummyCollectionViewSection())
                section.update(collectionView, with: value.data.movies)
                self.collectionView.updateCollectionViewCompositionalLayout(with: self)
            }
        }
    }
    
    
    @objc private func segmentControlValueChanged() {
//        self.compositionalLayoutSections.first?.dataSource?.items
    }
}

