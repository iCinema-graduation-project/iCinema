//
//  MovieProfileViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 11/03/2023.
//

import UIKit
import SwiftUI

class MovieProfileViewController: ICinemaViewController {

    var viewModel: MovieProfileViewModel?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let viewModel = viewModel else { return }

        let movieProfileView =  MovieProfileView()
            .environmentObject(viewModel)
            .hostigView()
        
        view.addSubview(movieProfileView)
        movieProfileView.fillSuperviewConstraints()
        
        
        viewModel.dismissAction = {
            self.dismiss()
        }
        
        viewModel.bookNow = { movie in
            Booking.shared.startBooking(movie.id)
        }
        
    }
    
    
    public func inject(with movieId: Int) {
        
    }
    
    
}
