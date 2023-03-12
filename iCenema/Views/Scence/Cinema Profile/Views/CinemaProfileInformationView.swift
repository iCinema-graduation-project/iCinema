//
//  CinemaProfileInformationView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 06/03/2023.
//

import SwiftUI

struct CinemaProfileInformationView: View {
    let cinema: Cinema
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            VStack {
                Divider()
                HStack(alignment: .center, spacing: 10) {
                    // Rate
                    RateCinameInformationView(cinema: cinema)
                    Divider().frame(height: .cinemaProfile.cinemaInformationViewDividerHeight)
                    // Follow Count
                    CinemaInformationView(caption2: "followers",
                                          title: "\(cinema.followersCount)",
                                          caption: "Count")
                    // Location
                    CinemaInformationView(caption2: "location",
                                          title: "Cairo",
                                          caption: "Egypt")
                    // Size
                    CinemaInformationView(caption2: "size",
                                          title: "\(cinema.ChairsCount)",
                                          caption: "Chairs", hasLeftDivider: false)
                }
                .frame(height: 80)
                Divider()
            }
            .padding(.horizontal)
        }
        .padding(.bottom)

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
                    .font(Font(UIFont.footnote))
                    .foregroundColor(.gray)
                /// title Text
                Text(title.capitalized)
                    .font(Font(UIFont.title2))
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
    let cinema: Cinema
    var body: some View {
        VStack(alignment: .center,  spacing: 8) {
            Text("10K RATINGS")
                .font(Font(UIFont.footnote))
                .foregroundColor(.gray)
            
            Text(String(format: "%.1f", cinema.rate))
                .font(Font(UIFont.title2))

            HStack(alignment: .center, spacing: 5.0) {
                ForEach(0..<5) { i in
                    Image(systemName: "star.fill")
                        .resizable()
                        .foregroundColor(Int(floor(cinema.rate)) > i ? Color(uiColor: .iCinemaYellowColor) : .gray)
                        .frame(width: 10, height: 10)
                }
            }
        }
        .frame(width: .cinemaProfile.cinemaInformationViewWidth)
    }
}



