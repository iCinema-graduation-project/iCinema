//
//  AppTapBarController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 23/02/2023.
//

import UIKit
import SwiftUI

class AppTapBarController: ICinemaViewController {
    var tabBarView: UIView?
    
    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menuVC = MenuCoordinator().navigationController
        buildCoordinator(vc: menuVC, image: ImageManager.tabBar.menu, selectedImage: ImageManager.tabBar.menuSelected, tag: 0)
        
        let reelsVC = ReelsCoordinator().navigationController
        buildCoordinator(vc: reelsVC, image: ImageManager.tabBar.reels, selectedImage: ImageManager.tabBar.reelsSelected, tag: 1)

        let homeVC = HomeCoordinator().navigationController
        buildCoordinator(vc: homeVC, image: ImageManager.tabBar.home, selectedImage: ImageManager.tabBar.homeSelected, tag: 2)

        let ticketVC = TicketCoordinator().navigationController
        buildCoordinator(vc: ticketVC, image: ImageManager.tabBar.ticket, selectedImage: ImageManager.tabBar.ticketSelected, tag: 3)

        let notificationVC = NotificationCoordinator().navigationController
        buildCoordinator(vc: notificationVC, image: ImageManager.tabBar.notification, selectedImage: ImageManager.tabBar.notificationSelected, tag: 4)

        let viewControllers = [menuVC, reelsVC, homeVC, ticketVC, notificationVC]
        guard let tabBarView = UIHostingController(rootView: AppTabBarView(tabs: viewControllers, selectedTabIndex: 2)).view else { return }
        self.tabBarView = tabBarView
        view.addSubview(tabBarView)
 
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tabBarView?.fillXSuperViewConstraints()
        tabBarView?.makeConstraints(topAnchor: view.safeAreaLayoutGuide.topAnchor, bottomAnchor: view.bottomAnchor)
    }
    
    // MARK: - Intializers
    //
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        coordinatorType = .segue
        modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Functions
    //
    private func buildCoordinator(vc: UIViewController, image: UIImage?, selectedImage: UIImage?, tag: Int) {
        vc.tabBarItem = UITabBarItem(title: nil, image: image, tag: tag)
        vc.tabBarItem.selectedImage = selectedImage
    }
    
}


struct AppTapBarControllerView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIViewController

    func makeUIViewController(context: Context) -> UIViewController {
        return AppTapBarController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}

struct AppTapBarControllerView_Previews: PreviewProvider {
    static var previews: some View {
        AppTapBarControllerView()
            .ignoresSafeArea()
    }
}
