//
//  MovieCellView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 11/03/2023.
//

import SwiftUI
import UIKit




struct MovieCellView: View {
    
    var movie: Movie
    
    @State var bookmarked = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 5) {

                Image(movie.poster)
                    .resizable()
                    .addBorder(withColor: Color(uiColor: .iCinemaYellowColor),
                               height: .home.movies.imageHeight)
                
                HStack {
                    Text(movie.name)
                        .font(Font(UIFont.body))
                        .lineLimit(1)
                    Spacer()
                    Button {
                        bookmarked.toggle()
                    } label: {
                        BookMark(bookmarked: bookmarked)
                    }
                }
                
                // Ciname
                HStack {
                    Image("cinema")
                        .makeCircled(size: CGSize(width: 10, height: 10),
                                     strockColor: Color(uiColor: .iCinemaYellowColor),
                                     lineWidth: 0.5)
                    Text("Galaxy")
                        .font(Font(UIFont.caption1))
                }
                
                // Cinema Location
                HStack {
                    Image(systemName: UIImage.location)
                        .resizable()
                        .frame(width: 12, height: 12)
                        .foregroundColor(Color(uiColor: .iCinemaYellowColor))
                    
                    Text("Cairo / 2.3km")
                        .font(Font(UIFont.caption1))
                }
       
                // MARK: - Genre
                Text("Action, Horror, Tragety")
                    .font(Font(UIFont.caption2))
                    .foregroundColor(.gray)
            

                
                Spacer()
            }
            .padding(.horizontal, .cell.padding.left + 10)
            .padding(.top, .cell.padding.top)
            .foregroundColor(Color(uiColor: .iCinemaTextColor))

        }
        .frame(width: .home.movies.size.width, height: .home.movies.size.height)
        .background(Color(uiColor: .iCinemaSecondBackgroudColor))
        .onAppear {
            bookmarked = movie.bookmarket
        }
    }
}

struct MovieCellView_Previews: PreviewProvider {
    static var previews: some View {
        var movie = Movie(poster: "posterImage", name: "Black Adam", bookmarket: true)
        MovieCellView(movie: movie)
    }
}


struct BookMark: View {
    let bookmarked: Bool
    var body: some View {
        Image(systemName: bookmarked ? UIImage.bookmarkFill : UIImage.bookmark)
            .resizable()
            .frame(width: .bookmark.width, height: .bookmark.height)
            .foregroundColor(Color(uiColor: .iCinemaYellowColor))
        
    }
}
