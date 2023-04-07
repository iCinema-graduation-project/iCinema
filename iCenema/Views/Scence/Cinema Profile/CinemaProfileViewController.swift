//
//  CinemaProfileViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 04/03/2023.
//

import UIKit
import SwiftUI
import Foundation
import Combine


class CinemaProfileViewController: ICinemaViewController {
    
    var viewModel: CinemaProfileViewModel?
    
    var cancellableSet: Set<AnyCancellable> = []
    
    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let viewModel = viewModel else { return }
        
        coordinatorType = .segue
        
        let cinemaProfileView = CinemaProfileView()
            .environmentObject(viewModel)
            .hostigView()
            
        
        self.view.addSubview(cinemaProfileView)
        cinemaProfileView.fillSuperviewConstraints()
        
        viewModel.dismissAction = {
                self.dismiss()
        }
        
        
        viewModel.showMore = { movie in

            let movieVC = MovieProfileViewController()
            movieVC.setup(movie: movie)
            self.presentViewController(movieVC)
            
        }
        
        
        
        viewModel.bookNow = { movie in
            print(movie.name)

            self.dismiss()
            TabBarViewModel.shared.hide()
            self.presenterViewController?.coordinator?.push()
            
        }
        
    }
    
    
}
