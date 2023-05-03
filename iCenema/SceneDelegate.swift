//
//  SceneDelegate.swift
//  iCinema
//
//  Created by Ahmed Yamany on 27/01/2023.
//

import UIKit

let deviceID = UIDevice.current.identifierForVendor!.uuidString

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        let appCoordinator = AppCoordinator()
        window.rootViewController = appCoordinator.rootViewController
        
        window.makeKeyAndVisible()
        self.window = window
        
        self.updateSegmentControl()

    }
    
    private func updateSegmentControl() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .iCinemaYellowColor
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.iCinemaTextColorReverce,
                                                                .font: UIFont.callout
        ], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.font: UIFont.body], for: .normal)
    }


}




