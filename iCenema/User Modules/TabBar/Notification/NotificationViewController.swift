//
//  NotificationViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 24/02/2023.
//

import UIKit
import CompositionalLayoutableSection
import SwiftUI

class NotificationViewController: ICinemaViewController, CompositionalLayoutProvider {
    // MARK: - Views
    //
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())

    // MARK: - CompositionalLayoutProvider confirmation
    //
    lazy var compositionalLayoutSections: [CompositionalLayoutableSection] = [ ]
    private lazy var datesource = CompositionalLayoutDataSource(self)
    private lazy var delegate = CompositionalLayoutDelegate(self)
    
    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // update collection view delegation
        collectionView.delegate = delegate
        collectionView.dataSource = datesource
        
        let section = NotificationCollectionViewSection(hostingViewController: self)
        compositionalLayoutSections.append(section)
        section.update(self.collectionView, with: [NotificationModel(title: "hello"), NotificationModel(title: "hello")])
        
        self.collectionView.updateCollectionViewCompositionalLayout(with: self)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }

    
    // MARK: - Update UI
    private func updateUI(){
        navigationItem.addTitleView(title: "Notifications", color: .iCinemaYellowColor)
        self.addCollectionView()
    }
    private func addCollectionView() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
    }
}


struct NotificationView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIViewController

    func makeUIViewController(context: Context) -> UIViewController {
        return UINavigationController(rootViewController: NotificationViewController())
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
            .ignoresSafeArea()
    }
}
