//
//  AppTapBarController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 23/02/2023.
//

import UIKit
import SwiftUI
import MakeConstraints

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
        
        let home = HomeCoordinator()
        let homeVC = home.navigationController
        Booking.shared.homeCoordinator = home
        buildCoordinator(vc: homeVC, image: .tabBar.home, selectedImage: .tabBar.homeSelected, tag: 2)
        
        let ticketVC = TicketCoordinator().navigationController

        buildCoordinator(vc: ticketVC, image: .tabBar.ticket, selectedImage: .tabBar.ticketSelected, tag: 3)
        
        let notificationVC = NotificationCoordinator().navigationController
        buildCoordinator(vc: notificationVC, image: .tabBar.notification, selectedImage: .tabBar.notificationSelected, tag: 4)
        
        let viewControllers = [menuVC, reelsVC, homeVC, ticketVC, notificationVC]
        
        self.tabBarView = AppTabBarView(tabs: viewControllers,
                                        tabBarViewModel: TabBarViewModel.shared).hostigView()
        view.addSubview(tabBarView!)
        tabBarView?.fillSuperviewConstraints()
        
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
    //
    private func buildCoordinator(vc: UIViewController, image: UIImage?, selectedImage: UIImage?, tag: Int) {
        vc.tabBarItem = UITabBarItem(title: nil, image: image, tag: tag)
        vc.tabBarItem.selectedImage = selectedImage
    }
    
}


struct AppTapBarView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIViewController

    func makeUIViewController(context: Context) -> UIViewController {
        return UINavigationController(rootViewController: AppTapBarController())
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}

struct AppTapBarView_Previews: PreviewProvider {
    static var previews: some View {
        AppTapBarView()
            .ignoresSafeArea()
    }
}
