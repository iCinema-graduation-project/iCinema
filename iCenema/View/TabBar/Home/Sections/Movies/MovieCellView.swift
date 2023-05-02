//
//  MovieCellView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 11/03/2023.
//

import SwiftUI
import UIKit
import Kingfisher
import SPAlert
import NetworkLayer

struct MovieCellView: View {
    
    var movie: Movie
    
    @State var movieSaver =  MovieSaver()
    
    @State var saved: Bool = false
    @State var showAlert: Bool = false
    @State var alertMessage: String = ""
    
    var body: some View {
        VStack {
            
            VStack(alignment: .leading, spacing: 5) {
                self.movieImage()
                self.movieName()
                self.movieCinema()
                self.cinemaLocation()
             
                /// Movie Genries
                Text("Action, Horror, Tragety")
                    .font(Font(UIFont.caption2))
                    .foregroundColor(.gray)

                Spacer()
            }
            .padding(.horizontal, .cell.padding.top)
            .padding(.top, .cell.padding.top)
            .foregroundColor(Color(uiColor: .iCinemaTextColor))
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: .iCinemaSecondBackgroudColor))
        .onAppear {
            saved = movie.saved
        }
    }
    
    
    @ViewBuilder
    private func movieImage() -> some View {
        AsyncImage(url: URL(string: movie.image)) { image in
            image
                .resizable()

        } placeholder: {
            Color.gray
        }
        .addBorder(withColor: Color(uiColor: .iCinemaYellowColor),
                           height: .home.movies.imageHeight)

    }
    
    @ViewBuilder
    private func movieName() -> some View {
        HStack {
            Text(movie.name)
                .font(Font(UIFont.body))
                .lineLimit(1)
            Spacer()
            
            BookMark(bookmarked: saved,
                     bookmarkedImage: UIImage.bookmarkFill,
                     notBookmarkedImage: UIImage.bookmark)
            .frame(width: .bookmark.width,  height: .bookmark.height)
            .SPAlert(isPresent: $showAlert, message: alertMessage)
            .onTapGesture {
                saved.toggle()
               
                movieSaver.update(id: movie.id)
             
                movieSaver.request { response in
                    if let value = response.value {
                        self.alertMessage = value.msg

                    } else if let error = response.error {
                        self.alertMessage = NetworkError.getErrorMessage(from: error)

                    }else {
                        self.alertMessage = "Unkown error"
                    }
                    self.showAlert = true
                }
                
            }
        }
    }
    
    @ViewBuilder
    private func movieCinema() -> some View {
        HStack {
            AsyncImage(url: URL(string: movie.cinema.logo)) { image in
                image
                    .resizable()
                    

            } placeholder: {
                Color.gray
            }
            .makeCircled(size: CGSize(width: 15, height: 15),
                         strockColor: Color(uiColor: .iCinemaYellowColor),
                         lineWidth: 0.5)
            
            Text(movie.cinema.name)
                .font(Font(UIFont.caption1))
        }

    }
    
    @ViewBuilder
    private func cinemaLocation() -> some View {
        HStack {
            Image(systemName: UIImage.location)
                .resizable()
                .frame(width: 12, height: 12)
                .foregroundColor(Color(uiColor: .iCinemaYellowColor))

            Text(movie.cinema.distance ?? "")
                .font(Font(UIFont.caption1))
                .lineLimit(1)
        }

    }
    
}

//struct MovieCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        let movie = Movie(Slider: "SliderImage", name: "Black Adam", bookmarket: true)
//        MovieCellView(movie: movie)
//    }
//}


struct BookMark: View {
    let bookmarked: Bool
    var bookmarkedImage: String
    var notBookmarkedImage: String
    var body: some View {
        Image(systemName: bookmarked ? bookmarkedImage : notBookmarkedImage)
            .resizable()
            .foregroundColor(Color(uiColor: .iCinemaYellowColor))
        
    }
}
