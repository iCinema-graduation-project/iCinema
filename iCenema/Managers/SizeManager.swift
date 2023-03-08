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
    static let iCinemaButtonWidth: CGFloat = 200
    static let iCinemaButtonHeight: CGFloat = 40
    static let iCinemaButtonCornerRadius: CGFloat = 20
    
    // MARK: - Home Posters Section
    static let homePosterSupplementaryHeight: CGFloat = 30
    static let homePosterHeight: CGFloat = 276
    static let homePoseterWidth: CGFloat = 240
    static let homePosterSectionHeight: CGFloat = CGFloat.homePosterHeight + CGFloat.iCinemaButtonHeight + 15

    // MARK: - Home
    // MARK: - Movies Section
    static let moviesSupplementaryHeight: CGFloat = 50
    static let movieCellWidth: CGFloat = 168
    static let movieCellHeight: CGFloat = 224
    static let moviesPadding: CGFloat = 8
    
    // MARK: - Cinemas Section
    static let cinemaCellWidth: CGFloat = 168
    static let cinemaCellHeight: CGFloat = 184
    
    
    // MARK: - Cinema Profile
    static let cinemaProfile = CinemaProfile()
    struct CinemaProfile{
        let cinemaImageHeight: CGFloat = 88
        let cinemaInformationViewWidth: CGFloat = 90
        let cinemaInformationViewDividerHeight: CGFloat = 40
    }
    
}



