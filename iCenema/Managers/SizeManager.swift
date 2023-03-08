//
//  .swift
//  iCinema
//
//  Created by Ahmed Yamany on 30/01/2023.
//

import Foundation


extension CGFloat {
    // MARK: - View
    static let viewWidth: CGFloat = 320
    static let viewPadding: CGFloat = 48
    static let viewCornerRadius: CGFloat = 15
    static let viewBorderWidth: CGFloat = 0.8
    
    // MARK: - ICinema Button
    static let iCinemaButton = ICinemaButton.self
    
    struct ICinemaButton {
        static let width: CGFloat = 200
        static let height: CGFloat = 40
        static let cornerRadius: CGFloat = 25
        
    }
    
    // MARK: - Home
    static let home = Home()
    struct Home {
        let posters = Posters.self
        let movies = Movies.self
        let cinemas = Cinemas.self
        
        struct Posters {
            static let supplementaryHeight: CGFloat = 30
            static let height: CGFloat = 276
            static let width: CGFloat = 240
            static let sectionHeight: CGFloat = CGFloat.home.posters.height + CGFloat.iCinemaButton.height + 15
        }
        struct Movies {
            static let supplementaryHeight: CGFloat = 50
            static let cellWidth: CGFloat = 168
            static let cellHeight: CGFloat = 224
            static let padding: CGFloat = 8
        }
        struct Cinemas {
            static let cinemaCellWidth: CGFloat = 168
            static let cinemaCellHeight: CGFloat = 184
        }
    }
    
    
    // MARK: - Cinema Profile
    static let cinemaProfile = CinemaProfile.self
    struct CinemaProfile{
        static let cinemaImageHeight: CGFloat = 88
        static let cinemaInformationViewWidth: CGFloat = 90
        static let cinemaInformationViewDividerHeight: CGFloat = 40
    }
    
}



