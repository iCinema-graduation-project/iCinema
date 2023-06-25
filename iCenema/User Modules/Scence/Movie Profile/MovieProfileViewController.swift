//
//  MovieProfileViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 11/03/2023.
//

import UIKit
import SwiftUI
import MakeConstraints

class MovieProfileViewController: ICinemaViewController {

    var viewModel: MovieProfileViewModel = .init()

    var service: NetworkLayer<MovieProfileModel> = .init(endpoint: "movies/details", method: .get)

    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateDismissAction()
        self.updateStartBookingMovie()
        self.updateShowCinemaInformation()
        
    }
    
    // MARK: - Update UI
    //
    private func updateUI() {
        let movieProfileView =  MovieProfileView(view: self)
            .environmentObject(viewModel)
            .hostigView()
        
        view.addSubview(movieProfileView)
        movieProfileView.fillSuperviewConstraints()  
    }
    
    // MARK: -
    //
    public func inject(with movieId: Int) {
        self.service.networkRequest.update(parameters: ["id": movieId])
        self.makeNetworkRequest()
        
    }
    
    private func makeNetworkRequest() {
        ActivityIndicator.shared.play()
        self.service.request { response in
            ActivityIndicator.shared.stop()
            
            if let value = response.value {
                self.updateUI()
                self.viewModel.updateModel(with: value.data)
                print(self.viewModel.id)
            } else {
                super.handelError(response.error)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.dismiss()
                }
            }
        }
    }

    
    // MARK: - Helper
    private func updateDismissAction() {
        self.viewModel.dismissAction = {
                self.dismiss()
        }
    }
    
    private func updateStartBookingMovie() {
        viewModel.startBookingMovie = { movie in
            Booking.shared.startBooking(movie)
        }
    }
    private func updateShowCinemaInformation() {
        viewModel.showCinemaInformation = { cinemaId in
            let cinemaProfile = CinemaProfileViewController()
            cinemaProfile.inject(with: cinemaId)
            self.presentViewController(cinemaProfile)
        }
    }

    
}
