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
    // MARK: - Views
    var menu: MenuView!
    
    // MARK: - Properties
    var cancelableSet: Set<AnyCancellable> = []
    
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        menu = MenuView()

        self.layoutMenuView()
        self.bindViewModel()
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.addTitleView(title: "Menu")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        cancelableSet.forEach { $0.cancel() }
        cancelableSet.removeAll()
    }
    
    // MARK: - Update UI
    //
    private func layoutMenuView() {
        let menuView = menu.hostigView()
        view.addSubview(menuView)
        
        menuView.fillXSuperViewConstraints()
        menuView.makeConstraints(topAnchor: view.safeAreaLayoutGuide.topAnchor,
                                 bottomAnchor: view.bottomAnchor)
        
    }
    
    // MARK: -  Helper
    private func bindViewModel() {
        menu.viewModel.$viewController.sink { viewController in
            guard let viewController = viewController else { return }
            self.navigationController?.pushViewController(viewController.init(), animated: true)
        }
        .store(in: &cancelableSet)
    }
    
}
