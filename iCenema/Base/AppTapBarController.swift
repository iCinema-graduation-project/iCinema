//
//  AppTapBarController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 23/02/2023.
//

import UIKit
import SwiftUI

class AppTapBarController: ViewController {
    var tabBArView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc1 = ViewController()
        vc1.tabBarItem = UITabBarItem(title: nil, image: ImageManager.tabBar.menu, tag: 0)
        vc1.tabBarItem.selectedImage = ImageManager.tabBar.menuSelected
        

        let vc2 = ViewController()
        vc2.tabBarItem = UITabBarItem(title: nil, image: ImageManager.tabBar.reels, tag: 1)
        vc2.tabBarItem.selectedImage = ImageManager.tabBar.reelsSelected
        
        let vc3 = ViewController()
        vc3.tabBarItem = UITabBarItem(title: nil, image: ImageManager.tabBar.home, tag: 2)
        vc3.tabBarItem.selectedImage = ImageManager.tabBar.homeSelected
        
        let vc4 = ViewController()
        vc4.tabBarItem = UITabBarItem(title: nil, image: ImageManager.tabBar.ticket, tag: 3)
        vc4.tabBarItem.selectedImage = ImageManager.tabBar.ticketSelected

        let vc5 = ViewController()
        vc5.tabBarItem = UITabBarItem(title: nil, image: ImageManager.tabBar.notigication, tag: 4)
        vc5.tabBarItem.selectedImage = ImageManager.tabBar.notigicationSelected

        
        guard let tabBArView = UIHostingController(rootView: AppTabBarView(tabs: [vc1, vc2, vc3, vc4, vc5], selectedTabIndex: 2)).view else { return }
        self.tabBArView = tabBArView
        view.addSubview(tabBArView)
        
    
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tabBArView?.frame = view.bounds
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        coordinatorType = .segue
        modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
