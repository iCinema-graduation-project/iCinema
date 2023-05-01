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
        self.updateUI()
        self.updateDismissAction()
        self.updateStartBookingMovie()
    }
    
    // MARK: - Update UI
    //
    private func updateUI() {
        let movieProfileView =  MovieProfileView()
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
                withAnimation(.linear(duration: 0.5)) {
                    self.viewModel.updateModel(with: value.data)
                }
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

    
}
