//
//  CinemaProfileHeaderView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 06/03/2023.
//

import SwiftUI

struct CinemaProfileHeaderView: View {
    @EnvironmentObject var viewModel: CinemaProfileViewModel

    @State var followed = false
    
    var body: some View {
        VStack {
            // Ciname Profile Image
            Image("cinema")
                .makeCircled(size: CGSize(width: .cinemaProfile.imageSize.width, height: .cinemaProfile.imageSize.height),
                             strockColor: Color(uiColor: .iCinemaYellowColor),
                             strockSpacing: 12,
                             lineWidth: 3)

            // Cinema Name
            Text(viewModel.cinema.name + " Cinema")
                .foregroundColor(Color(uiColor: .iCinemaTextColor))
                .font(Font(UIFont.title3))
            
            // Follow Button
            ICinemaButtonView(title: followed ? .follow : .unfollow) {
                followed.toggle()
                viewModel.followButtonTapped()
            }
            
        }
        .onAppear {
//            followed = viewModel.cinema.followed
        }
    }
}

