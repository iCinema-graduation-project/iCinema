//
//  ICinemaWalletViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 23/04/2023.
//

import Foundation

final class ICinemaWalletViewController: ICinemaViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.addTitleView(title: .menu.icinemaWallet)
        
        let iCinemaWalletView = ICinemaWalletView().hostigView()
        view.addSubview(iCinemaWalletView)

        iCinemaWalletView.fillXSuperViewConstraints()
        iCinemaWalletView.makeConstraints(topAnchor: view.safeAreaLayoutGuide.topAnchor,
                                          bottomAnchor: view.bottomAnchor)
        
        
    }
}
