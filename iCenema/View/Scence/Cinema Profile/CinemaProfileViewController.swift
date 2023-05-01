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
    
    lazy var viewModel: CinemaProfileViewPresenter = .init(view: self)

    var service: NetworkLayer<CinemaProfileModel> = .init(endpoint: "cinemas/details", method: .get)

    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
        self.updateDismissAction()
        
        
        viewModel.showMore = { movie in
            let movieVC = MovieProfileViewController()
            movieVC.viewModel = .init()
            self.presentViewController(movieVC)
        }


        viewModel.bookNow = { movie in
            Booking.shared.startBooking(movie)
        }
        
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
                    self.viewModel.cinema = value.data
                }
                
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
    
    public func startBooking(_ movieID: Int) {
        TabBarViewModel.shared.selectedTabIndex = 2
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {

            homeCoordinator?.push(userInfo: ["movie": movieID])
        })
        
    }

}

