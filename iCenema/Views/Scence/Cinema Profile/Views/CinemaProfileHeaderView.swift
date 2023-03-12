//
//  CinemaProfileHeaderView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 06/03/2023.
//

import SwiftUI

struct CinemaProfileHeaderView: View {
    let cinema: Cinema
        
    let imageHeight: CGFloat = .cinemaProfile.cinemaImageHeight
    
    var body: some View {
        VStack {
            // Ciname Profile Image
            Image("cinema")
                .makeCircled(size: CGSize(width: imageHeight, height: imageHeight),
                             strockColor: Color(uiColor: .iCinemaYellowColor),
                             strockSpacing: 12,
                             lineWidth: 3)

            // Cinema Name
            Text(cinema.name + " Cinema")
                .foregroundColor(Color(uiColor: .iCinemaTextColor))
                .font(Font(UIFont.title2))
            
            // Follow Button
            ICinemaButtonView(title: "Follow") {
//                print(Int(floor(cinema.rate)))
            }
            
        }
    }
}

