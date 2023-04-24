//
//  HomeViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 24/02/2023.
//

import UIKit
import SwiftUI
import ViewAnimator

 
final class HomeViewController: ICinemaViewController, CompositionalLayoutProvider {

    // MARK: - Views
    //
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    
    let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: SearchResultViewController())
        searchController.searchBar.tintColor = .iCinemaYellowColor
        searchController.searchBar.searchTextField.textColor = .iCinemaTextColor
        return searchController
    }()
    
    
    // MARK: - CompositionalLayoutProvider confirmation
    //
    lazy var compositionalLayoutSections: [CompositionalLayoutableSection] = [
        PosterCollectionViewSection(hostingViewController: self),
        MoviesCollectionViewSection(hostingViewController: self),
        CinemaCollectionViewSection(hostingViewController: self),
        MoviesCollectionViewSection(hostingViewController: self),
        DummyCollectionViewSection()
    ]
    
    var compositionalLayoutProviderDataSource: UICollectionViewDataSource?
    var compositionalLayoutProviderDelegate: UICollectionViewDelegate?
    
    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
        
        compositionalLayoutProviderDataSource = CompositionalLayoutDataSource(self)
        compositionalLayoutProviderDelegate = CompositionalLayoutDelegate(self)
        
        collectionView.delegate = compositionalLayoutProviderDelegate
        collectionView.dataSource = compositionalLayoutProviderDataSource
        
        collectionView.updatecollectionViewCompositionalLayout(with: self)
        self.compositionalLayoutSections.forEach { $0.delegate?.updateItems(self.collectionView) }
        
        LocationManager.shared.startUpdatingLocation()

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
                                                            style: .plain, target: self,
                                                            action: #selector(self.magnifyingGlassTappedAction))
       
        self.searchController.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
        
    }
    
    private func addUserProfileImageToLeftBarButtonItem(){
        
        let imageView = UIImageView(image: UIImage(named: "profile"))
            .makeCircleImage(withWidth: .profile.imageSize.width)
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imageView)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.userProfileTapped))
        imageView.addGestureRecognizer(gesture)
    }
    
    private func addCollectionView() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
    }
    
    @objc private func userProfileTapped() {
        self.navigationController?.pushViewController(UserProfileViewController(), animated: true)
    }
    
    @objc private func magnifyingGlassTappedAction() {
        
        if navigationItem.searchController == nil {
        
            navigationItem.searchController = searchController
            let zoomAnimation = AnimationType.zoom(scale: 0.2)
            
            navigationItem.searchController?.searchBar.animate(animations: [zoomAnimation])

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                self.searchController.searchBar.becomeFirstResponder()
            })
            
        }
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if !searchController.isActive {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                self.navigationItem.searchController = nil
            })
        }
        
        
    }
    
}


struct HomeView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIViewController

    func makeUIViewController(context: Context) -> UIViewController {
        return UINavigationController(rootViewController: HomeViewController())
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .ignoresSafeArea()
    }
}
