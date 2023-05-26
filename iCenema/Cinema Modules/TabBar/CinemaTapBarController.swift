//
//  AppTapBarController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 23/02/2023.
//

import UIKit
import SwiftUI
import MakeConstraints

class CinemaTapBarController: ICinemaViewController {
    var tabBarView: UIView?

    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menuVC = ICinemaViewController()
        buildCoordinator(viewController: menuVC, image: UIImage.tabBar.menu, selectedImage: UIImage.tabBar.menuSelected, tag: 0)
        
        let homeViewController = CinemaHomeCoordinator().navigationController
        buildCoordinator(viewController: homeViewController, image: UIImage.tabBar.home, selectedImage: UIImage.tabBar.homeSelected, tag: 1)

        let notificationVC = CinemaNotificationViewController()
        buildCoordinator(viewController: notificationVC, image: UIImage.tabBar.notification, selectedImage: UIImage.tabBar.notificationSelected, tag: 2)

        
        let viewControllers: [UIViewController] = [menuVC, homeViewController, notificationVC]

        let tabBarView = AppTabBarView(tabs: viewControllers,
                                       tabBarViewModel: TabBarViewModel.shared).hostigView()
        self.tabBarView = tabBarView
        view.addSubview(tabBarView)
        tabBarView.fillSuperviewConstraints()

    }

    // MARK: - Intializers
    //
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        coordinationType = .segue
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helper Functions
    private func buildCoordinator(viewController: UIViewController,
                                  image: UIImage,
                                  selectedImage: UIImage,
                                  tag: Int) {
        viewController.tabBarItem = UITabBarItem(title: nil, image: image, tag: tag)
        viewController.tabBarItem.selectedImage = selectedImage
    }

}


