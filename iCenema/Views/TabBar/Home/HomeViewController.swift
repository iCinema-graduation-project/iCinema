//
//  HomeViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 24/02/2023.
//

import UIKit
import SwiftUI

 
final class HomeViewController: ICinemaViewController, CompositionalLayoutProvider {

    // MARK: - Views
    //
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    
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
                                                            style: .plain, target: self, action: nil)
        
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
