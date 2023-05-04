//
//  MovieProfileViewModel.swift
//  iCinema
//
//  Created by Ahmed Yamany on 11/04/2023.
//

import SwiftUI

class MovieProfileViewModel: ProfileViewDelegate, ObservableObject {
    @Published var id: Int = 0
    @Published var image: String = ""
    @Published var cover: String = ""
    @Published var name: String = ""
    @Published var saved: Bool = false
    @Published var cinema: CinemaProfileViewModel = .init()
    @Published var trailer: String = ""
    @Published var description: String = ""
    @Published var brief: String = ""
    @Published var releaseDate: String = ""
    @Published var timeInMinutes: Int = 0
    @Published var minAge: Int = 0
    @Published var averageRate: Int = 0
    @Published var categories: [Category] = []
    @Published var images: [MovieImage] = []
    @Published var comments: [String] = []
    @Published var videoPlayerViewModels: [VideoPlayerViewModel] = []

    var dismissAction: (() -> Void) = { }
    var startBookingMovie: ((_ movieId: Int) -> Void) = { _ in }
    
    public func updateModel(with movie: Movie) {
        self.id = movie.id
        self.image = movie.image
        self.cover = movie.cover ?? ""
        self.name = movie.name
        self.saved = movie.saved
        self.cinema.updateModel(with: movie.cinema)
        self.trailer = movie.trailer ?? ""
        self.description = movie.description ?? ""
        self.brief = movie.brief ?? ""
        self.releaseDate = movie.releaseDate ?? ""
        self.timeInMinutes = movie.timeInMinutes ?? 0
        self.minAge = movie.minAge ?? 0
        self.averageRate = movie.averageRate ?? 0
        self.categories = movie.categories ?? []
        self.images = movie.images ?? []
        self.comments = movie.comments ?? []
        self.videoPlayerViewModels.append(.init(url: URL(string: self.trailer)!))
    }
    
    

    
   
}
