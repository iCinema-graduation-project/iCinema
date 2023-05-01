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
    lazy var compositionalLayoutSections: [CompositionalLayoutableSection] = [ ]
    
    lazy var dataSource: UICollectionViewDataSource? = CompositionalLayoutDataSource(self)
    lazy var delegate: UICollectionViewDelegate? = CompositionalLayoutDelegate(self)
    
    
    var viewModel = FollowingViewModel()
    
    // MARK: - Life Cycle
    //
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.makeNetworkRequest()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
        // setup collection view delegate and datasource with compositional layout source and delegate
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.viewModel.service.cancelAllPublishers()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    private func makeNetworkRequest() {
        ActivityIndicator.shared.play()
        self.viewModel.service.networkRequest.update(headers: ["page": "1"])
        self.viewModel.service.request { response in
            ActivityIndicator.shared.stop()
            
            if let value = response.value{
                let sec = FollowingCollectionViewSection(hostingViewController: self)
                self.compositionalLayoutSections.append(sec)
                sec.update(self.collectionView, with: value.data.cinemas)
                
            }else {
                self.handelError(response.error)
            }
            
            self.compositionalLayoutSections.append(DummyCollectionViewSection())
            self.collectionView.updateCollectionViewCompositionalLayout(with: self)
            
            self.collectionView.reloadData()
        }
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


