//
//  AppTapBarController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 23/02/2023.
//

import UIKit
import SwiftUI


var iCinemaTabBar = TabBarViewModel()

class AppTapBarController: ICinemaViewController {
    var tabBarView: UIView?
    @State var isTabBarHidden = false
    
    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menuVC = MenuCoordinator().navigationController
        buildCoordinator(vc: menuVC, image: .tabBar.menu, selectedImage: .tabBar.menuSelected, tag: 0)
        
        let reelsVC = ReelsCoordinator().navigationController
        buildCoordinator(vc: reelsVC, image: .tabBar.reels, selectedImage: .tabBar.reelsSelected, tag: 1)

        let homeVC = HomeCoordinator().navigationController
        buildCoordinator(vc: homeVC, image: .tabBar.home, selectedImage: .tabBar.homeSelected, tag: 2)

        let ticketVC = TicketCoordinator().navigationController
        buildCoordinator(vc: ticketVC, image: .tabBar.ticket, selectedImage: .tabBar.ticketSelected, tag: 3)

        let notificationVC = NotificationCoordinator().navigationController
        buildCoordinator(vc: notificationVC, image: .tabBar.notification, selectedImage: .tabBar.notificationSelected, tag: 4)

        let viewControllers = [menuVC, reelsVC, homeVC, ticketVC, notificationVC]
        guard let tabBarView = UIHostingController(rootView: AppTabBarView(tabs: viewControllers, selectedTabIndex: 2, tabBarViewModel: iCinemaTabBar)).view else { return }
        
        self.tabBarView = tabBarView
        view.addSubview(tabBarView)
 
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tabBarView?.fillXSuperViewConstraints() // (paddingLeft: 8, paddingRight: 8)
        tabBarView?.makeConstraints(topAnchor: view.safeAreaLayoutGuide.topAnchor, bottomAnchor: view.bottomAnchor)
    }
    
    // MARK: - Intializers
    //
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        coordinatorType = .segue
        modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        coordinatorType = .segue
        modalPresentationStyle = .fullScreen
    }
    
    // MARK: - Helper Functions
    //
    private func buildCoordinator(vc: UIViewController, image: UIImage?, selectedImage: UIImage?, tag: Int) {
        vc.tabBarItem = UITabBarItem(title: nil, image: image, tag: tag)
        vc.tabBarItem.selectedImage = selectedImage
    }
    
}
