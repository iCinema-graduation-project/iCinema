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
    
    var viewModel: CinemaProfileViewModel = .init()

    var service: NetworkLayer<CinemaProfileModel> = .init(endpoint: "cinemas/details", method: .get)

    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
        self.updateDismissAction()
        
        /*
        viewModel.showMore = { movie in
            let movieVC = MovieProfileViewController()
            movieVC.viewModel = .init(movie: movie)
            self.presentViewController(movieVC)
        }


        viewModel.bookNow = { movie in
            Booking.shared.startBooking(movie)
        }
        */
    }
    
    // MARK: - Update UI
    private func updateUI() {
        let cinemaProfileView = CinemaProfileView()
            .environmentObject(self.viewModel)
            .hostigView()

        self.view.addSubview(cinemaProfileView)
        cinemaProfileView.fillSuperviewConstraints()

    }
    
    // MARK: - 
    public func inject(with cinemaID: Int) {
        self.service.networkRequest.update(parameters: ["id": cinemaID])
        self.makeNetworkRequest()
    }
    
    private func makeNetworkRequest() {
        print(self.service.networkRequest.parameters)
        self.service.request { response in
            if let _ = response.value {
                
                
            } else {
                self.handelError(response.error)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.dismiss()
                }
            }
        }

    }
    
    
    private func updateDismissAction() {
        self.viewModel.dismissAction = {
                self.dismiss()
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

