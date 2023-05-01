//
//  CinemaProfileViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 04/03/2023.
//

import UIKit
import SwiftUI


class CinemaProfileViewController: ICinemaViewController {
    
    lazy var viewModel: CinemaProfileViewModel = .init()

    var service: NetworkLayer<CinemaProfileModel> = .init(endpoint: "cinemas/details", method: .get)

    
    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
        self.updateDismissAction()
        self.updateShowMoreAboutMovie()
        self.updateStartBookingMovie()
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
        ActivityIndicator.shared.play()
        self.service.request { response in
            ActivityIndicator.shared.stop()
            
            if let value = response.value {
                withAnimation(.easeInOut(duration: 1)) {
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
    
    private func updateShowMoreAboutMovie() {
        viewModel.showMoreAboutMovie = { movie in
            let movieVC = MovieProfileViewController()
            movieVC.viewModel = .init()
            self.presentViewController(movieVC)
        }
    }
    
    private func updateStartBookingMovie() {
        viewModel.startBookingMovie = { movie in
            Booking.shared.startBooking(movie)
        }
    }
    
}


