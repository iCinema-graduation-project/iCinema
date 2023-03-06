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
                .frame(width: imageHeight, height: imageHeight)
                .mask(Circle())
                .overlay {
                    Circle()
                        .stroke(Color(uiColor: .iCinemaYellowColor), lineWidth: 3)
                        .frame(width: imageHeight + 12, height: imageHeight + 12)
                }
                .frame(width: imageHeight + 16, height: imageHeight + 16)
            
            // Cinema Name
            Text(cinema.name + " Cinema")
                .foregroundColor(Color(uiColor: .iCinemaTextColor))
                .font(.headline)
            
            // Follow Button
            ICinemaButtonView(title: "Follow") {
                print(Int(floor(cinema.rate)))
            }
        }
    }
}

