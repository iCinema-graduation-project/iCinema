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
import Coordinator
import LocationManager

class CinemaProfileViewController: ICinemaViewController {
    
    var viewModel: CinemaProfileViewModel?
    
    var cancellableSet: Set<AnyCancellable> = []
    
    let manager = LocationManager()

        
    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let viewModel = viewModel else { return }
        
        coordinationType = .segue
        
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
            movieVC.viewModel = .init(movie: movie)
            self.presentViewController(movieVC)
        }
        
        
        viewModel.bookNow = { movie in
            Booking.shared.startBooking(movie)
        }
        
        
    }
    
}

struct Booking {
    static var shared = Booking()
    
    var homeCoordinator: Coordinator? = nil
    
    public func startBooking(_ movie: Movie) {
        TabBarViewModel.shared.selectedTabIndex = 2
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {

            homeCoordinator?.push(userInfo: ["movie": movie])
        })
        
    }

}

