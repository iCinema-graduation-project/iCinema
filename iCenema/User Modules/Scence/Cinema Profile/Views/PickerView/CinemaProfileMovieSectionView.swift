//
//  CinemaProfileMovieSection.swift
//  iCinema
//
//  Created by Ahmed Yamany on 07/03/2023.
//

import SwiftUI

struct MoviesListView: View {
    var body: some View {
     Text("j")

    }
}

struct CinemaProfileMovieSection_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView()
    }
}


struct MovieListView: View {
    var body: some View {
        HStack {
            Image("posterImage")
                .resizable()
                .frame(width: 84, height: 120)
            
            VStack(alignment: .leading) {
                Text("Avatar")
                    .padding(.top)
                Text("Genre: Action")
                Spacer()
            
            }
            Spacer()
        }
        .frame(height: 120)
        .background(Color.red)
        .padding(.horizontal)
    }
}
