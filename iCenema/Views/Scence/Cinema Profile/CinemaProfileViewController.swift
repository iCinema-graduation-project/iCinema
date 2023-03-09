//
//  CinemaProfileViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 04/03/2023.
//

import UIKit
import SwiftUI

class CinemaProfileViewController: ICinemaViewController {
 
    var cinema: Cinema?
    var dismissButtonAction: (() -> Void)?
    
    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cinemaProfileView = CinemaProfileView { self.dismissButtonAction?() }
        guard let cinemaProfileView = UIHostingController(rootView: cinemaProfileView).view else { return }
        
        self.view.addSubview(cinemaProfileView)
        cinemaProfileView.fillSuperviewConstraints()
        
    }
    
    public func setup(cinema: Cinema?, dismissButtonAction: (() -> Void)?) {
        self.cinema = cinema
        self.dismissButtonAction = dismissButtonAction
    }
}

