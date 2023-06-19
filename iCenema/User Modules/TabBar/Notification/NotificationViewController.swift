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
        let models: [NotificationModel] = [
            NotificationModel(image: "n1", title: "Your ticket is in 12 hours from now , don't forget to activate it .", time: "Today 10:00 PM"),
            NotificationModel(image: "n2", title: "Rivoly Cinema added a new movie .", time: "Today 12:20 PM"),
            NotificationModel(image: "n3", title: "The premier of Black Adam will be in 3 days , you con book your ticket now .", time: "Today 06:30 AM"),
            NotificationModel(image: "n4", title: "Galaxy Cinema : after watching our movie, we hope you will rate us .", time: "Yesterday 05:00 PM")
        ]
        section.update(self.collectionView, with: models)
        
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
