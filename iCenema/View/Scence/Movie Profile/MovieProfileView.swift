//
//  MovieProfileView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 08/03/2023.
//

import SwiftUI
import Combine

struct MovieProfileView: View {
    @EnvironmentObject var viewModel: MovieProfileViewModel
    
    var body: some View {
        
        ProfileView(profileViewDelegate: viewModel, imageUrl: viewModel.image, ingnoreSaveArea: .all) {
            VStack {
                movieImage()
                movieName()
             
                VStack {}.frame(height: 200)
            }
            
        }
        .onDisappear {
            self.viewModel.videoPlayerViewModel?.player?.pause()
            self.viewModel.videoPlayerViewModel?.player = nil
        }
    }
    
    @ViewBuilder
    private func movieImage() -> some View {
        AsyncImage(url: URL(string: viewModel.image)) { image in
            image.resizable()
        } placeholder: {
            Color.gray
        }
        
        .frame(height: 350)
        .addBorder(withColor: Color(uiColor: .iCinemaYellowColor), cornorRadius: 30, height: 353)
    }
    
    @ViewBuilder
    private func movieName() -> some View {
        VStack {
            Text(viewModel.name)
                .font(Font(UIFont.title1))
                .foregroundColor(Color(uiColor: .iCinemaTextColor))
            
            ICinemaButtonView(title: .bookNow, action: {
                self.viewModel.startBookingMovie(self.viewModel.id)
            })
            .padding(.bottom)
            
            Text(viewModel.brief)
                .multilineTextAlignment(.center)
                .lineSpacing(10)
                .font(Font(UIFont.body))
            
            HStack {
                self.text(viewModel.releaseDate)
                self.text("\(viewModel.timeInMinutes) M")
                self.text("\(viewModel.minAge)+")
            }
            
            Divider()
            if let videoPlayerViewModel = self.viewModel.videoPlayerViewModel {
                PlayerView(viewModel: videoPlayerViewModel)
                    .frame(height: 200)
                    .cornerRadius(20)
            }
        }
        .foregroundColor(Color(uiColor: .iCinemaTextColor))
        .padding()
    }
    
    @ViewBuilder
    private func text(_ string: String) -> some View {
        Text(string)
            .font(Font(UIFont.callout))
            .padding(.horizontal)
            .frame(height: 28)
            .background(Color(uiColor: .iCinemaYellowColor))
            .foregroundColor(Color(uiColor: .iCinemaTextColorReverce))
            .cornerRadius(10)
    }
    
    
    
    @ViewBuilder
    private func viewss() -> some View {
        VStack(alignment: .center){
            
            HStack {
                Text("English")
                    .font(.system(size: 12))
                    .padding(.horizontal)
                    .frame(height: 28)
                    .background(Color(uiColor: .iCinemaSecondBackgroudColor))
                    .cornerRadius(10)
                
                Text("2.45 h")
                    .font(.system(size: 12))
                    .padding(.horizontal)
                    .frame(height: 28)
                    .background(Color(uiColor: .iCinemaSecondBackgroudColor))
                    .cornerRadius(10)
                
                Text("+12")
                    .font(.system(size: 12))
                    .padding(.horizontal)
                    .frame(height: 28)
                    .background(Color(uiColor: .iCinemaSecondBackgroudColor))
                    .cornerRadius(10)
            }
            
            //
            ICinemaButtonView(title: "Book Now", action: {
//                viewModel.bookNow(viewModel.movie)
            })
            .padding()
            
//            PlayerView(viewModel: playerModel)
//                .frame(height: 200)
//                .cornerRadius(20)
        }
        .padding(.horizontal)
        .onDisappear(){
            
        }
    }
    
}


struct MovieProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = MovieProfileViewModel()
        
        let movie = Movie(id: 1, image: "http://icinema.live/defaults/default.png", cover: Optional("http://icinema.live/defaults/default.png"), name: "Lilly Wehner III", saved: false, cinema: iCinema.Cinema(id: 1, logo: "http://icinema.live/defaults/default.png", cover: Optional("http://icinema.live/defaults/default.png"), name: "Dr. Stella Ritchie", following: Optional(false), averageRate: Optional(0), countFollow: nil, address: Optional("91894 Viviane Station\nNorth Laurenland, KS 42786-6649"), distance: Optional("11927.36km"), images: nil, movies: nil), trailer: Optional("http://icinema.live/defaults/default_video.mp4"), description: Optional("Alice quite jumped; but she thought it would be like, \'--for they haven\'t got much evidence YET,\' she said to herself, \'Why, they\'re only a pack of cards, after all. I needn\'t be afraid of them!\'."), brief: Optional("Alice thought over all the rest of it in the house down!\' said the Pigeon went on, half to Alice. \'Only a thimble,\' said Alice indignantly. \'Ah! then yours wasn\'t a really good school,\' said the."), releaseDate: Optional("2022-03-18"), timeInMinutes: Optional(71), minAge: Optional(12), averageRate: Optional(0), categories: Optional([iCinema.Category(id: 14, name: "Romance"), iCinema.Category(id: 18, name: "American"), iCinema.Category(id: 22, name: "English")]), images: Optional([iCinema.MovieImage(id: 1, image: "http://icinema.live/defaults/default.png")]), comments: Optional([]))
        viewModel.updateModel(with: movie)

        return MovieProfileView()
            .environmentObject(viewModel)
    }
}





//func typeWriter(str: String, at position: Int = 0) {
//
//    if position < str.count {
//        // Run the code inside the DispatchQueue after 0.2s
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
//            text.append(str[position])
//            typeWriter(str: str, at: position + 1)
//        }
//    }
//}
//extension String {
//    subscript(offset: Int) -> Character {
//        self[index(startIndex, offsetBy: offset)]
//    }
//}
