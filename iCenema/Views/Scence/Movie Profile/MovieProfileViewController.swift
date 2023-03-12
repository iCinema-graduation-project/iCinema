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
    var dismissButtonAction: (() -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mv =  MovieProfileView(closeButtonAction: { self.dismissButtonAction?() })
        guard let movieProfileView = UIHostingController(rootView: mv).view else { return }
        
        view.addSubview(movieProfileView)
        movieProfileView.fillSuperviewConstraints()

    }
    
    
    public func setup(movie: Movie?, dismissButtonAction: (() -> Void)?) {
        self.movie = movie
        self.dismissButtonAction = dismissButtonAction
    }
    
}
