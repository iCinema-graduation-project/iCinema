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
import Kingfisher

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
    lazy var compositionalLayoutSections: [CompositionalLayoutableSection] = [ ]
    private lazy var datesource = CompositionalLayoutDataSource(self)
    private lazy var delegate = CompositionalLayoutDelegate(self)
    
    var viewModel = HomeViewModel()
    var profileFeatcher = ProfileFetcher()
    
    // MARK: - Life Cycle
    //
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TabBarViewModel.shared.show()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // update home UI
        self.updateUI()
        
        // update collection view delegation
        collectionView.delegate = delegate
        collectionView.dataSource = datesource
        
        // start updating location
        LocationManager.shared.startUpdatingLocation()
        
        // make network request
        ActivityIndicator.shared.play()
        self.makeNetworkRequest { ActivityIndicator.shared.stop() }
        
        // add refresh controll
        self.collectionView.addUIRefreshControl(target: self,
                                                action: #selector(collectionViewRefershControlAction),
                                                for: .valueChanged)
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
    //
    private func makeNetworkRequest(_ completion: @escaping () -> Void = {}) {
        self.viewModel.service.request { [ unowned self ] response in
            
            if let value = response.value, let homeData = value.data{
                self.makeHomeLayout(with: homeData)
            }else {
                self.handelError(response.error)
            }
            
            self.compositionalLayoutSections.append(DummyCollectionViewSection())
            self.collectionView.updateCollectionViewCompositionalLayout(with: self)
            completion()
        }
    }
    private func makeHomeLayout(with home: HomeData) {
        self.compositionalLayoutSections.removeAll()
        self.makeHomeSlider(from: home.homeSlides)
        self.makeCategories(from: home.categories)
    }
    private func makeHomeSlider(from homeSlides: [HomeSlide]) {
        let Slider = SliderCollectionViewSection(hostingViewController: self)
        self.compositionalLayoutSections.append(Slider)
        Slider.update(self.collectionView, with: homeSlides)
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
        let imageView = UIImageView()
            .makeCircleImage(withWidth: .profile.imageSize.width, borderColor: .iCinemaYellowColor)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imageView)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.userProfileTapped))
        imageView.addGestureRecognizer(gesture)
        self.profileFeatcher.request { response in
            guard let value = response.value  else{ return }
            imageView.kf.setImage(with: URL(string: value.user.image ?? "" ))
        }
    }
    private func addCollectionView() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
    }
    
    // MARK: - Actions
    @objc func collectionViewRefershControlAction() {
        self.collectionView.refreshControl?.beginRefreshing()
        self.makeNetworkRequest { [ unowned self ] in
            self.collectionView.refreshControl?.endRefreshing()
        }
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
        
        let query = searchController.searchBar.text
        guard let query = query, query.count > 3, let searchResultVC = searchController.searchResultsController as? SearchResultViewController else {return}
        searchResultVC.updateSearch(with: query)
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
