//
//  MovieProfileViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 11/03/2023.
//

import UIKit
import SwiftUI

class MovieProfileViewController: ICinemaViewController {

    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mv =  MovieProfileView(closeButtonAction: {
            self.dismiss()
        })
        guard let movieProfileView = UIHostingController(rootView: mv).view else { return }
        
        view.addSubview(movieProfileView)
        movieProfileView.fillSuperviewConstraints()
    }
    
    public func setup(movie: Movie?) {
        self.movie = movie
    }
    
}
