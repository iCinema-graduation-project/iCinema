//
//  HomeViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 24/02/2023.
//

import UIKit
import SwiftUI
import ViewAnimator
import CompositionalLayoutableSection
import LocationManager
import NetworkLayer
import SPAlert
 
final class HomeViewController: ICinemaViewController, CompositionalLayoutProvider {

    // MARK: - Views
    //
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    
    var refresher:UIRefreshControl = UIRefreshControl()
    
    let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: SearchResultViewController())
        searchController.searchBar.tintColor = .iCinemaYellowColor
        searchController.searchBar.searchTextField.textColor = .iCinemaTextColor
        return searchController
    }()
    
    
    // MARK: - CompositionalLayoutProvider confirmation
    //
    lazy var compositionalLayoutSections: [CompositionalLayoutableSection] = [ ]
    
    private lazy var datesource: UICollectionViewDataSource? = CompositionalLayoutDataSource(self)
    private lazy var delegate: UICollectionViewDelegate? = CompositionalLayoutDelegate(self)
    
    
    var viewModel = HomeViewModel()
    
    // MARK: - Life Cycle
    //
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TabBarViewModel.shared.show()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
        
        collectionView.delegate = delegate
        collectionView.dataSource = datesource
     
        LocationManager.shared.startUpdatingLocation()
        
        ActivityIndicator.shared.play()
        self.networkRequest { ActivityIndicator.shared.stop() }
        
        self.refresher = UIRefreshControl()
        self.collectionView.alwaysBounceVertical = true
        self.refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        collectionView.refreshControl = self.refresher
     
        refresher.tintColor = .iCinemaYellowColor
        
    }
    
    @objc func loadData() {
        self.collectionView.refreshControl?.beginRefreshing()
        
//        self.networkRequest {
//            self.stopRefresher()
//        }
     }
    
    func stopRefresher() {
       self.collectionView.refreshControl?.endRefreshing()
     }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
 
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.viewModel.service.cancelAllPublishers()
    }
    
    // MARK: - Network
    
    private func networkRequest(_ completion: @escaping () -> Void = {}) {
        self.viewModel.service.request { response in
            
            if let value = response.value, let home = value.data{
                self.makeHomeSlider(from: home.homeSlides)
                self.makeCategories(from: home.categories)

            }else {
                self.handelError(response.error)
            }
            
            self.compositionalLayoutSections.append(DummyCollectionViewSection())
            self.collectionView.updateCollectionViewCompositionalLayout(with: self)
            completion()
        }
    }
    
    private func makeHomeSlider(from homeSlides: [HomeSlide]) {
        let poster = PosterCollectionViewSection(hostingViewController: self)
        self.compositionalLayoutSections.append(poster)
        poster.update(self.collectionView, with: homeSlides)
    }
    
    private func makeCategories(from categories: [HomeCategory]) {
        for category in categories {
            if category.type == "movies", let movies = category.movies {
                self.makeMoviesSection(from: movies, withTitle: category.title)
            } else if category.type == "cinemas", let cinemas = category.cinemas {
                self.makeCinemasSection(from: cinemas, withTitle: category.title)
            }
        }
    }
    
    private func makeMoviesSection(from movies: [Movie], withTitle title: String) {
        let movieSection = MoviesCollectionViewSection(hostingViewController: self, supplementaryViewTitle: title)
        self.compositionalLayoutSections.append(movieSection)
        movieSection.update(self.collectionView, with: movies)

    }
    
    private func makeCinemasSection(from cinemas: [Cinema], withTitle title: String) {
        let cinemaSection = CinemaCollectionViewSection(hostingViewController: self, supplementaryViewTitle: title)
        self.compositionalLayoutSections.append(cinemaSection)
        cinemaSection.update(self.collectionView, with: cinemas)

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
            .makeCircleImage(withWidth: .profile.imageSize.width, borderColor: .iCinemaYellowColor)
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imageView)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.userProfileTapped))
        imageView.addGestureRecognizer(gesture)
    }
    
    private func addCollectionView() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
    }
    
    
    @objc private func userProfileTapped() {
        self.navigationController?.pushViewController(EditUserProfileViewController(), animated: true)
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
