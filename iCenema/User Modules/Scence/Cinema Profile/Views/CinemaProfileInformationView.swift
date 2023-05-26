//
//  CinemaProfileInformationView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 06/03/2023.
//

import SwiftUI

struct CinemaProfileInformationView: View {
    @EnvironmentObject var viewModel: CinemaProfileViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            VStack {
                Divider()
                HStack(alignment: .center, spacing: 10) {
                    self.cinemaRate()
                    Divider().frame(height: .cinemaProfile.cinemaInformationViewDividerHeight)
                    self.cinemaFollowCount()
                    self.cinemaLocation()
                    self.cinemaSize()
                }
                .frame(height: .cinemaProfile.imageSize.height)
                Divider()
            }
            .padding(.horizontal)
        }

    }
    
    @ViewBuilder
    private func cinemaRate() -> some View {
        RateCinameInformationView()
            .environmentObject(viewModel)
    }
    
    @ViewBuilder
    private func cinemaFollowCount() -> some View {
        CinemaInformationView(caption2: .cinemaProfile.followers,
                              title: "\(viewModel.countFollow)",
                              caption: .cinemaProfile.count)
    }
    
    @ViewBuilder
    private func cinemaLocation() -> some View {
        CinemaInformationView(caption2: .cinemaProfile.location,
                              title: "Cairo",
                              caption: "Egypt")
    }
    
    @ViewBuilder
    private func cinemaSize() -> some View {
        CinemaInformationView(caption2: .cinemaProfile.size,
                              title: "50",
                              caption: .cinemaProfile.chairs, hasLeftDivider: false)
    }

}
struct CinemaInformationView: View {
    let caption2: String
    var title: String
    var caption: String
    var hasLeftDivider = true
    
    var body: some View {
        HStack {
            VStack(alignment: .center, spacing: 8) {
                /// caption Text
                Text(caption2.uppercased())
                    .font(Font(UIFont.callout))
                    .foregroundColor(.gray)
                
                /// title Text
                Text(title.capitalized)
                    .font(Font(UIFont.title3))
                
                /// caption Text
                Text(caption.capitalized)
                    .font(Font(UIFont.caption1))
                    .foregroundColor(.gray)
            }
            .frame(width: .cinemaProfile.cinemaInformationViewWidth)
            if hasLeftDivider {
                Divider().frame(height: .cinemaProfile.cinemaInformationViewDividerHeight)
            }
        }
    }
}

struct RateCinameInformationView: View {
    @EnvironmentObject var viewModel: CinemaProfileViewModel

    var body: some View {
        VStack(alignment: .center,  spacing: 8) {
            Text(String.cinemaProfile.ratings)
                .font(Font(UIFont.callout))
                .foregroundColor(.gray)
            
            Text(String(format: "%.1f", viewModel.averageRate))
                .font(Font(UIFont.title2))
            
            RatingView(rate: viewModel.averageRate)
            
        }
        .frame(width: .cinemaProfile.cinemaInformationViewWidth)
    }
}


struct RatingView: View {
    
    let rate: Int
    var width: CGFloat = 10
    var height: CGFloat = 10
    
    var body: some View {
        HStack(alignment: .center, spacing: 5.0) {
            ForEach(0..<5) { i in
                Image(systemName: "star.fill")
                    .resizable()
                    .foregroundColor(rate > i ? Color(uiColor: .iCinemaYellowColor) : .gray)
                    .frame(width: width, height: height)
            }
        }

    }
}

