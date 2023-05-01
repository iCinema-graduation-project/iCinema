//
//  CinemaProfileHeaderView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 06/03/2023.
//

import SwiftUI

struct CinemaProfileHeaderView: View {
    @EnvironmentObject var viewModel: CinemaProfileViewPresenter

    @State var followed = false
    
    var body: some View {
        VStack {
            // Ciname Profile Image
            AsyncImage(url: URL(string: viewModel.cinema?.logo ?? "")) { image in
                image
                    .makeCircled(size: CGSize(width: .cinemaProfile.imageSize.width, height: .cinemaProfile.imageSize.height),
                                 strockColor: Color(uiColor: .iCinemaYellowColor),
                                 strockSpacing: 12,
                                 lineWidth: 3)
                
            } placeholder: {
                Color.gray
            }
            .frame(width: .cinemaProfile.imageSize.width, height: .cinemaProfile.imageSize.height)
            
            
            // Cinema Name
            Text(viewModel.cinema?.name ?? "")
                .foregroundColor(Color(uiColor: .iCinemaTextColor))
                .font(Font(UIFont.title3))
                .lineLimit(1)
            
            // Follow Button
            ICinemaButtonView(title: followed ? .unfollow : .follow) {
                followed.toggle()
                viewModel.followButtonTapped()
            }
        }
        .onAppear {
            followed = viewModel.cinema?.following ?? false
        }
        .transition(.move(edge: .leading))


        
       
    }
}

