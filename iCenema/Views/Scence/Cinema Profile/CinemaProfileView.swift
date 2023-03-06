//
//  CinemaProfileView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 05/03/2023.
//

import SwiftUI
import SwiftUITrackableScrollView

struct CinemaProfileView: View {
    let cinema: Cinema = Cinema(name: "Galaxy", followersCount: 63, rate: 3.5, ChairsCount: 430)
    
    @State private var scrollViewContentOffset = CGFloat(0)
    
    var body: some View {
        TrackableScrollView(.vertical, showIndicators: false, contentOffset: $scrollViewContentOffset) {
            VStack {
                CinemaProfileHeader(cinema: cinema)
                    .padding(.bottom)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(0..<5) { i in
                            Image("hale")
                                .frame(width: 288, height: 144)
                        }
                    }
                    .padding(.leading)

                }
                
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: .iCinemaBackgroundColor))
        .onChange(of: scrollViewContentOffset, perform: { value in
               
            
        })
    }
}

struct CinemaProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CinemaProfileView()
    }
}

struct CinemaProfileHeader: View {
    let cinema: Cinema
    
    //    let
    
    var body: some View {
        VStack {
            // Ciname Profile Image
            Image("cinema")
                .frame(width: .cinemaImageHeight, height: .cinemaImageHeight)
                .mask(Circle())
                .overlay {
                    Circle()
                        .stroke(Color(uiColor: .iCinemaYellowColor), lineWidth: 3)
                        .frame(width: .cinemaImageHeight + 12, height: .cinemaImageHeight + 12)
                }
                .frame(width: .cinemaImageHeight + 16, height: .cinemaImageHeight + 16)
            // Cinema Name
            Text(cinema.name + " Cinema")
                .foregroundColor(Color(uiColor: .iCinemaTextColor))
                .font(.headline)
            
            // Follow Button
            ICinemaButtonView(title: "Follow") {
                print(Int(floor(cinema.rate)))
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                VStack {
                    Divider()
                    HStack(alignment: .center, spacing: 10) {
                        
                        // Rate
                        RattingView(cinema: cinema)
                        Divider().frame(height: 40)
                        
                        // Follow Count
                        FollowCountView(cinema: cinema)
                        Divider().frame(height: 40)
                        
                        // Location
                        LocationView(cinema: cinema)
                        Divider().frame(height: 40)

                        // Size
                        CinemaSizeView(cinema: cinema)
                        Divider().frame(height: 40)
                        

                    }
                    .frame(height: 80)
                    Divider()
                }
                .padding(.horizontal)
            }
            
        }
        
        
    }
}


struct RattingView: View {
    let cinema: Cinema
    var body: some View {
        VStack(alignment: .center,  spacing: 8) {
            Text("10K RATINGS")
                .font(.system(.caption2))
                .foregroundColor(.gray)
            
            Text(String(format: "%.1f", cinema.rate))
                .font(.title2)
            
            HStack(alignment: .center, spacing: 5.0) {
                ForEach(0..<5) { i in
                    Image(systemName: "star.fill")
                        .resizable()
                        .foregroundColor(Int(floor(cinema.rate)) > i ? Color(uiColor: .iCinemaYellowColor) : .gray)
                        .frame(width: 10, height: 10)
                }
            }
        }
        .frame(width: 85)
        .padding(.horizontal)
    }
}

struct FollowCountView: View {
    let cinema: Cinema
    var body: some View {
        VStack(alignment: .center,  spacing: 8) {
            Text("FOLLOWERS")
                .font(.system(.caption2))
                .foregroundColor(.gray)
            
            Text("\(cinema.followersCount)")
                .font(.title2)
            
            Text("Count")
                .font(.caption)
                .foregroundColor(.gray)
            
        }
        .frame(width: 85)
        .padding(.horizontal)
    }
}

struct CinemaSizeView: View {
    let cinema: Cinema
    
    var body: some View {
        VStack(alignment: .center,  spacing: 8) {
            Text("SIZE")
                .font(.system(.caption2))
                .font(Font.caption2)
            
                .foregroundColor(.gray)
            
            Text("\(cinema.ChairsCount)")
                .font(.title2)
            
            Text("Chairs")
                .font(.caption)
                .foregroundColor(.gray)
            
        }
        .frame(width: 85)
        .padding(.horizontal, 20)
    }
}

struct LocationView: View {
    let cinema: Cinema
    
    var body: some View {
        VStack(alignment: .center,  spacing: 8) {
            Text("LOCATION")
                .font(.system(.caption2))
                .font(Font.caption2)
            
                .foregroundColor(.gray)
            
            Text("Cairo")
                .font(.title2)
            
            Text("Egypt")
                .font(.caption)
                .foregroundColor(.gray)
            
        }
        .frame(width: 85)
        .padding(.horizontal, 20)
    }
}
