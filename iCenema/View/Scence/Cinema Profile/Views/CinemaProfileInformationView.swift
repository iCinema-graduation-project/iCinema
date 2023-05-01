//
//  CinemaProfileInformationView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 06/03/2023.
//

import SwiftUI

struct CinemaProfileInformationView: View {
    @EnvironmentObject var viewModel: CinemaProfileViewPresenter

    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
//            if let cinema = viewModel.cinema {
                VStack {
                    Divider()
                    HStack(alignment: .center, spacing: 10) {
                        // Rate
                        RateCinameInformationView(cinema: viewModel.cinema)
                        Divider().frame(height: .cinemaProfile.cinemaInformationViewDividerHeight)
                        
                        // Follow Count
                        CinemaInformationView(caption2: .cinemaProfile.followers,
                                              title: "\(viewModel.cinema?.countFollow ?? 0)",
                                                                  caption: .cinemaProfile.count)
//                         Location
                        CinemaInformationView(caption2: .cinemaProfile.location,
                                              title: "Cairo",
                                              caption: "Egypt")
                        // Size
                        CinemaInformationView(caption2: .cinemaProfile.size,
                                                                  title: "50",
                                                                  caption: .cinemaProfile.chairs, hasLeftDivider: false)
                    }
                    .frame(height: .cinemaProfile.imageSize.height)
                    Divider()
                }
                .padding(.horizontal)
                .transition(.move(edge: .trailing))

//            }
        }

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
    let cinema: Cinema?
    var body: some View {
        VStack {}
        VStack(alignment: .center,  spacing: 8) {
            Text("RATINGS")
                .font(Font(UIFont.callout))
                .foregroundColor(.gray)

            Text(String(format: "%.1f", cinema?.averageRate ?? "0.0"))
                .font(Font(UIFont.title2))

            HStack(alignment: .center, spacing: 5.0) {
                ForEach(0..<5) { i in
                    Image(systemName: "star.fill")
                        .resizable()
                        .foregroundColor(Int(floor(Double(cinema?.averageRate ?? Int(0.0)))) > i ? Color(uiColor: .iCinemaYellowColor) : .gray)
                        .frame(width: 10, height: 10)
                }
            }
        }
        .frame(width: .cinemaProfile.cinemaInformationViewWidth)
    }
}



