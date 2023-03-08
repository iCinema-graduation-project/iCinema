//
//  CinemaProfileMovieSection.swift
//  iCinema
//
//  Created by Ahmed Yamany on 07/03/2023.
//

import SwiftUI


struct MoviesListView: View {
    var body: some View {
        VStack(spacing: 15) {
            MovieListCellView()
            MovieListCellView()
            MovieListCellView()
            MovieListCellView()
        }
    
    }
}

struct CinemaProfileMovieSection_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView()
    }
}


struct MovieListCellView: View {
    var body: some View {
        HStack {
            Image("posterImage")
                .resizable()
                .frame(width: 100)
                .cornerRadius(5)
                .shadow(color: Color(uiColor: .iCinemaYellowColor), radius: 4)

            
            VStack(alignment: .leading,  spacing: 5) {
                HStack {
                    // MARK: - Name
                    Text("Avatar")
                        .font(.headline)
                    Spacer()
                    Image(systemName: "bookmark")
                        .resizable()
                        .frame(width: 10, height: 15)

                }
                
                HStack(spacing: 5) {
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundColor(Color(uiColor: .iCinemaYellowColor))
                    
                    // MARK: - Rate
                    Text("6.1/10")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
                
                // Genre
                HStack {
                    Image(systemName: "ellipsis.rectangle")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundColor(Color(uiColor: .iCinemaTextColor))
                    
                    // MARK: - Genre
                    Text("Action, Horror")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
                
                Text("To explore Pandora, genetically matched human scientists use Na'vi-human hybrids called \"avatars.\"")
                    .font(.system(size: 10))
                    .multilineTextAlignment(.leading)
                    .frame(height: 40)
                
                HStack {
                    // MARK: - Book Now
                    Button("More Details") {
                        
                    }
                    .font(.caption2)
                    
                    Spacer()
                    
                    ICinemaButtonView(title: "Book Now", width: 80, height: 24)

                }
                
                Spacer()
                
            }
            .padding(.leading)
            Spacer()
        }
        .frame(height: 140)
        .padding(5)
        .padding(.horizontal)
    }
}
