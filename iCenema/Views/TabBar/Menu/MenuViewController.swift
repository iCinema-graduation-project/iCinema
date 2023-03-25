//
//  MenuViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 24/02/2023.
//

import UIKit
import SwiftUI
import Combine



class MenuViewController: ICinemaViewController {
    
    var cancelableSet: Set<AnyCancellable> = []
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let menu = MenuView()
        
        let menuView = menu.hostigView()
        view.addSubview(menuView)
        menuView.fillXSuperViewConstraints()
        menuView.makeConstraints(topAnchor: view.safeAreaLayoutGuide.topAnchor, bottomAnchor: view.bottomAnchor)
        
        menu.viewModel.$viewController.sink { viewController in
            guard let viewController = viewController else { return }
            self.navigationController?.pushViewController(viewController.init(), animated: true)
        }
        .store(in: &cancelableSet)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.addTitleView(title: "Menu")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        cancelableSet.removeAll()
    }

}
