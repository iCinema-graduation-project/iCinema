//
//  CinemaProfileViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 04/03/2023.
//

import UIKit
import SwiftUI
import Foundation



class CinemaProfileViewController: ICinemaViewController {
 
    var cinema: Cinema?
    
    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cinemaProfileView = CinemaProfileView {
            self.dismiss()
        }
            
        guard let cinemaProfileView = UIHostingController(rootView: cinemaProfileView).view else { return }
        
        self.view.addSubview(cinemaProfileView)
        cinemaProfileView.fillSuperviewConstraints()
        
        NotificationCenter.default.addObserver(self, selector: #selector(userLoggedIn(_:)), name: .cinemaProfileMovieMoreDetails, object: nil)
    }
    
    @objc func userLoggedIn(_ notification: Notification) {
        let movieVC = MovieProfileViewController()
        movieVC.setup(movie: nil)
        self.presentViewController(movieVC)
    }
    
    
    public func setup(cinema: Cinema?) {
        self.cinema = cinema
    }
    
}
