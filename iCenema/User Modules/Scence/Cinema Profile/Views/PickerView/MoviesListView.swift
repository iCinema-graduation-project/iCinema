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
            ForEach(viewModel.movies, id: \.id) { movie in
                MovieListCellView(movie: movie)
                    .environmentObject(viewModel)
            }
        }
    }
}


struct MovieListCellView: View {
    let movie: CinemaMovie
    @EnvironmentObject var viewModel: CinemaProfileViewModel

    var showButtons = true
    @State var bookmarked = false
    @State var movieSaver =  MovieSaver()

    var body: some View {
        HStack {
            self.movieImage()
            VStack(alignment: .leading,  spacing: 5) {
                Spacer()
                self.movieName()
                self.movieRate()
                self.movieGenres()
                self.movieDescription()
                if self.showButtons {
                    self.navigationButtons()
                }
                Spacer()
                Divider()
            }
            .padding(.leading)
            Spacer()
        }
        .foregroundColor(Color(uiColor: .iCinemaTextColor))
        .frame(height: .cinemaProfile.movieListSize.height)
        .padding(5)
        .padding(.horizontal)
        .onAppear {
            bookmarked = movie.saved ?? false
        }
    }
    
    // Movie Image
    @ViewBuilder
    private func movieImage() -> some View {
        ICinemaAsyncImage(url: URL(string: movie.image)) { image in
            image
                .resizable()
                .addBorder(withColor: Color(uiColor: .iCinemaYellowColor),
                                                        height: .cinemaProfile.movieListSize.height)

        }
        .frame(width: .cinemaProfile.movieListSize.width, height: .cinemaProfile.movieListSize.height)
        .cornerRadius(.view.cornerRadius)

    }
    
    // Movie Name
    @ViewBuilder
    private func movieName() -> some View {
        HStack {
            Text(movie.name)
                .font(Font(UIFont.title3))
            Spacer()
            if self.showButtons {
                Button {
                    bookmarked.toggle()
                    movieSaver.update(id: movie.id)
                    movieSaver.request { _ in }
                } label: {
                    Image(systemName: bookmarked ? UIImage.bookmarkFill : UIImage.bookmark)
                        .resizable()
                        .frame(width: .bookmark.width, height: .bookmark.height)
                        .foregroundColor(Color(uiColor: .iCinemaYellowColor))
                }
            }
        }
    }
    
    
    @ViewBuilder
    private func movieRate() -> some View {
        HStack(spacing: 5) {
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: 10, height: 10)
                .foregroundColor(Color(uiColor: .iCinemaYellowColor))

            // MARK: - Rate
            Text("6/10")
                .font(Font(UIFont.caption1))
                .foregroundColor(.gray)
        }
    }
    
    @ViewBuilder
    private func movieGenres() -> some View {
        HStack {
            Image(systemName: "ellipsis.rectangle")
                .resizable()
                .frame(width: 10, height: 10)
                .foregroundColor(Color(uiColor: .iCinemaTextColor))

            // MARK: - Genre
            Text("Action, Horror")
                .font(Font(UIFont.caption1))
                .foregroundColor(.gray)
            
        }
    }
    
    
    @ViewBuilder private func movieDescription() -> some View {
        Text(movie.description)
            .font(Font(UIFont.caption1))
            .multilineTextAlignment(.leading)
            .frame(height: 40)
            .layoutPriority(1)
        
    }
    
    @ViewBuilder private func navigationButtons() -> some View {
        HStack {

            Button(String.moreDetails, role: .cancel) {
                viewModel.showMoreAboutMovie(movie.id)
            }
            .font(Font(UIFont.body))

            Spacer()

            ICinemaButtonView(title: .bookNow, type: .small) {

                viewModel.startBookingMovie(movie.id)

            }
        }

    }
}
