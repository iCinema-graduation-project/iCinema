//
//  CinemaProfileViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 04/03/2023.
//

import UIKit
import SwiftUI

class CinemaProfileViewController: ICinemaViewController {
    // MARK: - Properties
    //
   
    
    // MARK: - Views
    //
    
    
    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let CinemaProfileView = UIHostingController(rootView: CinemaProfileView()).view else { return }
        
        view.addSubview(CinemaProfileView)
//        CinemaProfileView.fillXSuperViewConstraints()
//        CinemaProfileView.makeConstraints(topAnchor: view.safeAreaLayoutGuide.topAnchor, bottomAnchor: view.bottomAnchor)
        CinemaProfileView.fillSuperviewConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
}

