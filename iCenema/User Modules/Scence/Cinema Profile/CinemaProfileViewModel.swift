//
//  CinemaProfileViewModel.swift
//  iCinema
//
//  Created by Ahmed Yamany on 28/03/2023.
//

import SwiftUI
import SPAlert
import NetworkLayer


class CinemaProfileViewModel: ProfileViewDelegate, ObservableObject {

    @Published var id: Int = 0
    @Published var logo: String = ""
    @Published var cover: String = ""
    @Published var name: String = ""
    @Published var following: Bool = false
    @Published var averageRate: Int = 0
    @Published var countFollow: Int = 0
    @Published var address: String = ""
    @Published var distance: String = ""
    @Published var images: [CinemaImage] = []
    @Published var movies: [CinemaMovie] = []
    
    var dismissAction: (() -> Void) = { }
    var startBookingMovie: ((_ movieId: Int) -> Void) = { _ in }
    var showMoreAboutMovie: ((_ movieId: Int) -> Void) = { _ in }
    
    var cinemaFollowingService = CinemaFollowingService()
    
    
    public func updateModel(with cinema: Cinema) {
        self.id = cinema.id
        self.logo = cinema.logo
        self.cover = cinema.cover ?? ""
        self.name = cinema.name ?? ""
        self.following = cinema.following ?? false
        self.averageRate = cinema.averageRate ?? 0
        self.countFollow = cinema.countFollow ?? 0
        self.address = cinema.address ?? ""
        self.distance = cinema.distance ?? ""
        self.images = cinema.images ?? []
        self.movies = cinema.movies ?? []
    }
    

    public func followButtonTapped() {
        cinemaFollowingService.update(id: id)
        
        ActivityIndicator.shared.play()
        cinemaFollowingService.request { response in
            ActivityIndicator.shared.stop()
            
            if let value = response.value {
                SPAlert.showAlert(with: value.msg)
            } else if let error = response.error {
                let errorMessage = NetworkError.getErrorMessage(from: error)
                SPAlert.showAlert(with: errorMessage)
            }else {
                SPAlert.showUnKnownError()
            }
            
        }
    }
    
   
}
