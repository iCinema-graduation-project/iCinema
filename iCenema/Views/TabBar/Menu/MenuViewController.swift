//
//  MenuViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 24/02/2023.
//

import UIKit
import SwiftUI

fileprivate final class Controller: ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let menuView = UIHostingController(rootView: MenuView()).view else { return }
        view.addSubview(menuView)
        menuView.fillSuperviewConstraints()
    }
}

class MenuViewController: ICinemaViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.presentViewController(Controller())
        navigationItem.addTitleView(title: "Menu")
        guard let menuView = UIHostingController(rootView: MenuView()).view else { return }
        view.addSubview(menuView)
//        menuView.fillSuperviewConstraints()
        menuView.fillXSuperViewConstraints()
        menuView.makeConstraints(topAnchor: view.safeAreaLayoutGuide.topAnchor, bottomAnchor: view.bottomAnchor)

    }

}
