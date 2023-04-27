//
//  SizeManager.swift
//  iCinema
//
//  Created by Ahmed Yamany on 30/01/2023.
//

import UIKit


extension CGFloat {
    
    static let supplementaryHeight: CGFloat = 44
    
    
    // MARK: - View
    static let view = View.self
    struct View {
        static let width: CGFloat = 320
        static let padding = UIEdgeInsets(top: 48, left: 32, bottom: 48, right: 32)
        static let cornerRadius: CGFloat = 16
        static let borderWidth: CGFloat = 0.8
        static let spacing: CGFloat = 36
    }
    
    // MARK: - ICinema Button
    static let iCinemaButton = ICinemaButton.self
    struct ICinemaButton {
        static let size = CGSize(width: 200, height: 40)
        static let smallButtonSize = CGSize(width: 88, height: 24)
        static let cornerRadius: CGFloat = CGFloat.iCinemaButton.size.width / 25 // = 8
    }
    
    // MARK: - Cell
    static let cell = Cell.self
    struct Cell {
        static let padding = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
    }
    
    // MARK: - Home
    static let home = Home.self
    struct Home {
        static let posters = Posters.self
        static let movies = Movies.self
        static let cinemas = Cinemas.self
        
        struct Posters {
            static let supplementaryHeight: CGFloat = 30

            static let size = CGSize(width: 240, height: 276)
            static let sectionHeight: CGFloat = CGFloat.home.posters.size.height + CGFloat.iCinemaButton.size.height + 15
        }
        struct Movies {
            static let size = CGSize(width: 168, height: 272)
            static let imageHeight: CGFloat = 170
        }
        struct Cinemas {
            static let size = CGSize(width: 168, height: 192)
            static let imageSize = CGSize(width: 60, height: 60)
        }
    }
    
    static let bookmark = CGSize(width: 12, height: 18)
    
    // MARK: - Cinema Profile
    static let profile = Profile.self
    struct Profile {
        static let imageSize = CGSize(width: 32, height: 32)
        static let strockLineWidth = 0.7
    }
    static let cinemaProfile = CinemaProfile.self
    struct CinemaProfile{
        static let imageSize = CGSize(width: 88, height: 88)
        static let cinemaInformationViewWidth: CGFloat = 90
        static let cinemaInformationViewDividerHeight: CGFloat = 40
        static let sliderSize = CGSize(width: CGFloat.view.width, height: 144)
        
        static let movieListSize = CGSize(width: 110, height: 140)
    }
    
    // MARK: - Movie Profile
    static let movieProfile = MovieProfile.self
    struct MovieProfile {
        
    }
}



