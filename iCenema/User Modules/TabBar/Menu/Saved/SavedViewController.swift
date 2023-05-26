//
//  SavedViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 12/04/2023.
//

import UIKit
import SwiftUI
import CompositionalLayoutableSection


final class SavedViewController: ICinemaViewController, CompositionalLayoutProvider {
    
    // MARK: - Views
    //
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    
    // MARK: - Properties
    //
    lazy var compositionalLayoutSections: [CompositionalLayoutableSection] = [ ]
    
    lazy var dataSource = CompositionalLayoutDataSource(self)
    lazy var delegate = CompositionalLayoutDelegate(self)
    
    var viewModel = SavedViewModel()
    
    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateUI()

        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
        
        ActivityIndicator.shared.play()
        self.makeNetworkRequest { ActivityIndicator.shared.stop() }
        
        self.collectionView.addUIRefreshControl(target: self,
                                                action: #selector(self.collectionViewRefershControlAction),
                                                for: .valueChanged)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.viewModel.service.cancelAllPublishers()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    // MARK: - Actions
    //
    @objc func collectionViewRefershControlAction() {
        self.collectionView.refreshControl?.beginRefreshing()
        self.makeNetworkRequest { [ unowned self ] in
            self.collectionView.refreshControl?.endRefreshing()
        }
    }

    
    // MARK: - Network
    //
    private func makeNetworkRequest(_ completion: @escaping () -> Void = {} ) {
        self.viewModel.service.networkRequest.update(headers: ["page": "1"])
        self.viewModel.service.request { [ unowned self ]  response in
            if let value = response.value{
                self.compositionalLayoutSections.removeAll()
                let sec = SavedCollectionViewSection(hostingViewController: self)
                self.compositionalLayoutSections.append(sec)
                sec.update(self.collectionView, with: value.data.movies)
                
            }else {
                self.handelError(response.error)
            }
            
            self.compositionalLayoutSections.append(DummyCollectionViewSection())
            self.collectionView.updateCollectionViewCompositionalLayout(with: self)
            
            completion()
        }
    }
    
    
    // MARK: - Update UI
    //
    private func updateUI(){
        navigationItem.addTitleView(title: .menu.saved)
        self.updateCollectionView()
    }
 
    private func updateCollectionView() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
    }

    
}



