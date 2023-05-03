//
//  CinemaProfileHeaderView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 06/03/2023.
//

import SwiftUI

struct CinemaProfileHeaderView: View {
    @EnvironmentObject var viewModel: CinemaProfileViewModel

    var body: some View {
        VStack {
            self.cinemaProfileImage()
            self.cinemaName()
            self.followButton()
        }
    }
    
    @ViewBuilder
    private func cinemaProfileImage() -> some View {
        ICinemaAsyncImage(url: URL(string: viewModel.logo)) { image in
            image
                .resizable()

            
        }
        .makeCircled(size: CGSize(width: .cinemaProfile.imageSize.width, height: .cinemaProfile.imageSize.height),
                     strockColor: Color(uiColor: .iCinemaYellowColor),
                     strockSpacing: 12,
                     lineWidth: 3)
        .frame(width: .cinemaProfile.imageSize.width, height: .cinemaProfile.imageSize.height)
    }
    
    
    @ViewBuilder
    private func cinemaName() -> some View {
        Text(viewModel.name)
            .foregroundColor(Color(uiColor: .iCinemaTextColor))
            .font(Font(UIFont.title3))
            .lineLimit(1)
    }
    
    @ViewBuilder
    private func followButton() -> some View {
        ICinemaButtonView(title: viewModel.following ? .unfollow : .follow) {
            viewModel.following.toggle()
            viewModel.followButtonTapped()
        }

    }
}

