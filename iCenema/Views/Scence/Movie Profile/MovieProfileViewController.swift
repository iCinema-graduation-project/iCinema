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
        
        let movieProfileView =  MovieProfileView(closeButtonAction: {
            self.dismiss()
        }).hostigView()
        
        view.addSubview(movieProfileView)
        movieProfileView.fillSuperviewConstraints()
    }
    
    public func setup(movie: Movie?) {
        self.movie = movie
    }
    
}
