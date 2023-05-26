//
//  MovieProfileView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 08/03/2023.
//

import SwiftUI
import Combine
import UIICinema
import SPAlert
import NetworkLayer

struct MovieProfileView: View {
    let view: MovieProfileViewController
    @EnvironmentObject var viewModel: MovieProfileViewModel
    @State var rate: Int = 2

    var body: some View {
        ProfileView(profileViewDelegate: viewModel, imageUrl: viewModel.image, ingnoreSaveArea: .all) {
            VStack {
                movieImage()
                movieInformation()
                moviesTrailserSection()
                movieRelatedSection()
                movieCastAndCrewSection()
                movieRatingsSection()
                aboutCinema()
                VStack {}.frame(height: 100)
            }
        }
        .onDisappear {
            self.viewModel.videoPlayerViewModels.forEach { videoPlayerViewModel in
                videoPlayerViewModel.player?.pause()
                videoPlayerViewModel.player = nil
            }
        }
    }
    
    private func movieImage() -> some View {
        ICinemaAsyncImage(url: URL(string: viewModel.image), addPlaceholder: false) { image in
            image.resizable()
        }
        .frame(height: 440)
        .addBorder(withColor: Color(uiColor: .iCinemaYellowColor),
                   cornorRadius: 30, height: 443)
    }
    
    private func movieInformation() -> some View {
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
            
        }
        .foregroundColor(Color(uiColor: .iCinemaTextColor))
        .padding()
    }
    
    private func text(_ string: String) -> some View {
        Text(string)
            .font(Font(UIFont.callout))
            .padding(.horizontal)
            .frame(height: 28)
            .background(Color(uiColor: .iCinemaYellowColor))
            .foregroundColor(Color(uiColor: .iCinemaTextColorReverce))
            .cornerRadius(10)
    }
    
    private func moviesTrailserSection() -> some View {
        ScrollableSectionView(title: .movieProfile.trailers) {
            ForEach(viewModel.videoPlayerViewModels, id: \.id) { videoPlayerViewModel in
                VideoPlayerView(viewModel: videoPlayerViewModel)
                    .frame(height: 200)
                    .frame(width: CGFloat.screenBounds.width - 40 )
                    .cornerRadius(20)
            }
        }
    }
    
    private func movieRelatedSection() -> some View {
        ScrollableSectionView(title: .movieProfile.related) {
            ForEach(viewModel.related, id: \.self) { movie in
                ICinemaAsyncImage(url: URL(string: movie.cover ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                .frame(width: 160, height: 95)
                .addBorder(withColor: Color(uiColor: .iCinemaYellowColor),
                           cornorRadius: .view.cornerRadius, height: 97)
                .onTapGesture {
                    let movieProfile = MovieProfileViewController()
                    movieProfile.inject(with: movie.id)
                    self.view.presentViewController(movieProfile)
                }
            }
        }
    }
    
    private func movieCastAndCrewSection() -> some View {
        ScrollableSectionView(title: .movieProfile.cast) {
            ForEach(0..<5, id: \.self) {_ in
                VStack {
                    ICinemaAsyncImage(url: URL(string: "http://icinema.live/defaults/default.png")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                    .makeCircled(size: CGSize(width: .cinemaProfile.imageSize.width,
                                              height: .cinemaProfile.imageSize.height),
                                 strockColor: Color.iCinemaYellowColor,
                                 strockSpacing: 5,
                                 lineWidth: 0.5)
                    
                    Text("Alex Gibney")
                        .foregroundColor(Color.iCinemaTextColor)
                        .font(.custom.body)
                    
                    Text("Director")
                        .foregroundColor(Color.gray)
                        .font(.custom.caption1)
                }
                .padding(.leading, .cell.padding.left)
            }
            .padding(.top, 5)
        }
      
    }
    
    private func movieRatingsSection() -> some View {
        ScrollableSectionView(title: "Ratings & Reviews", scrollable: false) {
            MovieRatings()
                .environmentObject(viewModel)
        }
    }
    
    private func aboutCinema() -> some View {
        ScrollableSectionView(title: "About Cinema", hasDivider: false, scrollable: false, content: {
            VStack(alignment: .leading, spacing: 10.0) {
                abountCinemaCell(title: "Name",
                                 subtitle: viewModel.cinemaProfileViewModel.name)
                abountCinemaCell(title: "Location",
                                 subtitle: viewModel.cinemaProfileViewModel.address)
                abountCinemaCell(title: "Average Rate",
                                 subtitle: String(viewModel.cinemaProfileViewModel.averageRate))
            }
            .padding(.horizontal, .cell.padding.left * 2)

        }, trailingContent: abountCinemaTrilingView )
    }
    
    private func abountCinemaCell(title: String, subtitle: String) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(Font.custom.footnote)
            
            Text(subtitle)
                .font(.custom.caption2)
                .foregroundColor(Color(uiColor: .darkGray))
        }
        .foregroundColor(.gray)
    }
    
    private func abountCinemaTrilingView() ->  some View {
        VStack {
            Text(String.moreDetails)
                .onTapGesture {
                    viewModel.showCinemaInformation(viewModel.cinemaProfileViewModel.id)
                }
                .font(Font.custom.callout)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .foregroundColor(.iCinemaYellowColor)
        }
    }
}

struct MovieRatings: View {
    @EnvironmentObject var viewModel: MovieProfileViewModel

    @State var alert = ICinemaAlert(height: 300)
    
    let text = """
    Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborum numquam blanditiis harum quisquam eius sed odit fugiat iusto fuga praesentium optio, eaque rerum! Provident similique accusantium nemo autem. Veritatis obcaecati tenetur iure eius earum ut molestias architecto voluptate aliquam nihil, eveniet aliquid culpa officia aut! Impedit sit sunt quaerat, odit, tenetur error, harum nesciunt ipsum debitis quas aliquid. Reprehenderit, quia. Quo neque error repudiandae fuga
    """
    
    @State var rateViewModel: RatingViewModel = RatingViewModel()
    @State var presentRatingView: Bool = false
    @State var alertMessage: String = ""
    
    @State var rateService: NetworkLayer<SaveMovieModel> = .init(endpoint: "movies/rate", method: .post)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5.0) {
            VStack {
                HStack {
                    averageRate()
                    Spacer()
                    ratingsProgressViews()
                }
                
                // add Review
                HStack {
                    Spacer()
                    Button {
                        alert.show {
                            self.addRatingsView()
                        }
                    } label: {
                        Label {
                            Text(String.movieProfile.addReview)
                        } icon: {
                            Image(systemName: "plus")
                        }
                        .font(Font.custom.callout)
                    }
                    .foregroundColor(.iCinemaYellowColor)
                }
                .SPAlert(isPresent: $presentRatingView, message: alertMessage, haptic: .success)
                
                
            }
            .padding(.horizontal, .cell.padding.left * 2)
            .foregroundColor(Color.iCinemaTextColor)
            ratings()
        }
    }
    
    private func averageRate() -> some View {
        VStack(spacing: -5.0) {
            Text("\(viewModel.averageRate)")
                .font(.custom(fontName, size: 60))
                .fontWeight(.bold)
            
            Text("out of 5")
                .font(Font.custom.callout)
                .foregroundColor(.gray)
        }
    }
    
    private func ratingsProgressViews() -> some View {
        HStack(spacing: 10.0) {
            VStack(alignment: .trailing, spacing: 3.0) {
                ForEach(0..<6, id: \.self) { index in
                    HStack(spacing: 1) {
                        ForEach(0..<5-index, id: \.self) { _ in
                            Image(systemName: "star.fill")
                                .resizable()
                                .frame(width: 7, height: 7)
                        }
                    }
                }
            }
            
            VStack(alignment: .trailing, spacing: 6.0) {
                ProgressView(value: (Double(viewModel.rates.rate5 / 5) * 0.1))
                    .tint(Color.iCinemaYellowColor)
                ProgressView(value: (Double(viewModel.rates.rate4 / 5) * 0.1))
                    .tint(Color.iCinemaYellowColor)
                ProgressView(value: (Double(viewModel.rates.rate3 / 5) * 0.1))
                    .tint(Color.iCinemaYellowColor)
                ProgressView(value: (Double(viewModel.rates.rate2 / 5) * 0.1))
                    .tint(Color.iCinemaYellowColor)
                ProgressView(value: (Double(viewModel.rates.rate1 / 5) * 0.1))
                    .tint(Color.iCinemaYellowColor)
                
            }
            .frame(width: 160)
        }
        .foregroundColor(.gray)
    }
    
    private func addRatingsView() -> some View {
        VStack {
            RatingAndReviewView(viewModel: rateViewModel)
            HStack(spacing: 20.0) {
                CancelButtonView(title: "cancele", type: .small) {
                    alert.hide()
                }
                
                ICinemaButtonView(title: "Send", type: .small) {
                    self.rateService.networkRequest.update(parameters: [
                        "id": viewModel.id,
                        "title": rateViewModel.title,
                        "rate": rateViewModel.rate,
                        "comment": rateViewModel.review
                    ])
                    
                    self.rateService.request { response in
                        if let value = response.value {
                            alertMessage = value.msg
                            presentRatingView = true
                        } else if let error = response.error {
                            alertMessage = NetworkError.getErrorMessage(from: error)
                            presentRatingView = true
                        }
                    }
                    
                    alert.hide()
                }
            }
        }
        .padding(.bottom)
    }
    
    
    private func ratings() -> some View {

        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(viewModel.comments, id: \.self) { comment in
                    VStack {
                        VStack(spacing: 0.0) {
                            HStack {
                                Text("Palestine in our Hearts")
                                    .font(Font.custom.callout)
                                Spacer()
                                Text(comment.createdAt)
                                    .font(Font.custom.body)
                                    .foregroundColor(.gray)
                            }
                            
                            HStack {
                                HStack(spacing: 3.0) {
                                    ForEach(0..<5, id: \.self) { index in
                                        Image(systemName: index > 1 ? "star" : "star.fill")
                                            .resizable()
                                            .frame(width: 10, height: 10)
                                            .foregroundColor(Color.iCinemaYellowColor)
                                    }
                                }
                                Spacer()
                                Text(comment.user.name)
                                    .font(Font.custom.body)
                                    .foregroundColor(.gray)
                            }

                            Text(comment.comment)
                                .font(Font.custom.body)
                                .multilineTextAlignment(.leading)
                                .lineSpacing(5)
                                .padding(.top, 5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                        }
                        .padding(10)
                    }
                    .foregroundColor(Color.iCinemaTextColor)
                    .frame(width: .screenBounds.width - 40, height: 170)
                    .padding(.leading, .cell.padding.left)
                    .background(Color.iCinemaSecondBackgroudColor)
                    .cornerRadius(.view.cornerRadius)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            
        }
        
    }
    
}


//struct MovieProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        let viewModel = MovieProfileViewModel()
//        
//        viewModel.updateModel(with: movie)
//
//        return MovieProfileView()
//            .environmentObject(viewModel)
//    }
//}





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
