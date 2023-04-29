//
//  CinemaProfileMovieSection.swift
//  iCinema
//
//  Created by Ahmed Yamany on 07/03/2023.
//

import SwiftUI


struct MoviesListView: View {
    @EnvironmentObject var viewModel: CinemaProfileViewModel

    var body: some View {
        VStack(spacing: 15) {
            ForEach(0..<5, id: \.self) { _ in
                MovieListCellView()
                    .environmentObject(viewModel)

            }
        
        }
    
    }
}

struct CinemaProfileMovieSection_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView()
    }
}


struct MovieListCellView: View {
    @EnvironmentObject var viewModel: CinemaProfileViewModel

    
//    let movie: Movie! // = Movie(poster: "posterImage", name: "Avatar", bookmarket: false)
    
    var showButtons = true
    @State var bookmarked = false
    
    var body: some View {
        VStack {}
        
//        HStack {
//            Image(movie.poster)
//                .resizable()
//                .cornerRadius(.view.cornerRadius)
//                .addBorder(withColor: Color(uiColor: .iCinemaYellowColor),
//                                                            height: .cinemaProfile.movieListSize.height)
//                            .frame(width: .cinemaProfile.movieListSize.width)
//
//            VStack(alignment: .leading,  spacing: 5) {
//                HStack {
//                    // MARK: - Name
//                    Text(movie.name)
//                        .font(Font(UIFont.title3))
//                    Spacer()
//                    if self.showButtons {
//                        Button {
//                            bookmarked.toggle()
//                        } label: {
//                            Image(systemName: bookmarked ? UIImage.bookmarkFill : UIImage.bookmark)
//                                .resizable()
//                                .frame(width: .bookmark.width, height: .bookmark.height)
//                                .foregroundColor(Color(uiColor: .iCinemaYellowColor))
//                        }
//                    }
//                }
//
//                HStack(spacing: 5) {
//                    Image(systemName: "star.fill")
//                        .resizable()
//                        .frame(width: 10, height: 10)
//                        .foregroundColor(Color(uiColor: .iCinemaYellowColor))
//
//                    // MARK: - Rate
//                    Text("6.1/10")
////                        .font(.caption2)
//                        .font(Font(UIFont.caption1))
//                        .foregroundColor(.gray)
//                }
//
//                // Genre
//                HStack {
//
//                    Image(systemName: "ellipsis.rectangle")
//                        .resizable()
//                        .frame(width: 10, height: 10)
//                        .foregroundColor(Color(uiColor: .iCinemaTextColor))
//
//                    // MARK: - Genre
//                    Text("Action, Horror")
////                        .font(.caption2)
//                        .font(Font(UIFont.caption1))
//                        .foregroundColor(.gray)
//                }
//
//                Text("To explore Pandora, genetically matched human scientists use Na'vi-human hybrids called \"avatars.\"")
//                    .font(Font(UIFont.caption1))
//                    .multilineTextAlignment(.leading)
//                    .frame(height: 40)
//                    .layoutPriority(1)
//
//                if self.showButtons {
//                    HStack {
//                        // MARK: - Book Now
//                        Button(String.moreDetails, role: .cancel) {
//                            viewModel.showMore(movie)
//                        }
//                        .font(Font(UIFont.body))
//
//                        Spacer()
//
//                        ICinemaButtonView(title: .bookNow, type: .small) {
//
//                            viewModel.bookNow(movie)
//
//                        }
//                    }
//                }
//
//                Spacer()
//                Divider()
//
//            }
//            .padding(.leading)
//            Spacer()
//        }
//        .foregroundColor(Color(uiColor: .iCinemaTextColor))
//        .frame(height: .cinemaProfile.movieListSize.height)
//        .padding(5)
//        .padding(.horizontal)
//        .onAppear {
//            bookmarked = movie.bookmarket
//        }
    }
}
