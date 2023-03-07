//
//  CinemaProfileViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 04/03/2023.
//

import UIKit
import SwiftUI

class CinemaProfileViewController: ICinemaViewController {
 
    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cinemaProfileView = CinemaProfileView {
            
        }
        
        guard let cinemaProfileView = UIHostingController(rootView: cinemaProfileView).view else { return }
        
        view.addSubview(cinemaProfileView)

        cinemaProfileView.fillSuperviewConstraints()
//        cinemaProfileView.fillXSuperViewConstraints()
//        cinemaProfileView.makeConstraints(topAnchor: view.safeAreaLayoutGuide.topAnchor, bottomAnchor: view.bottomAnchor)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
}

