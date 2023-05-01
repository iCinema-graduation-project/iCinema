//
//  CinemaCellView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 09/04/2023.
//

import SwiftUI
import SPAlert
import NetworkLayer

struct CinemaCellView: View {
    let cinema: Cinema
    
    @State var cinemaFollowing = CinemaFollowingService()
    @State var followed: Bool = false
    
    @State var showAlert: Bool = false
    @State var alertMessage: String = ""
    
    var body: some View {
        VStack {
            VStack {
                self.profileImage()

                Text(cinema.name)
                    .font(Font(UIFont.footnote))
                    .lineLimit(1)
                
                self.Location()
                self.rate()
                
                self.followButton()
             
            }
            .foregroundColor(Color(uiColor: .iCinemaTextColor))
            .padding(.horizontal, .cell.padding.left)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: .iCinemaSecondBackgroudColor))
        .onAppear {
            followed = cinema.following ?? false
        }

    }
    
    @ViewBuilder private func profileImage() -> some View {
        AsyncImage(url: URL(string: cinema.logo)) { image in
            image
                .resizable()
        } placeholder: {
            Color.gray
        }
        .makeCircled(size: CGFloat.home.cinemas.imageSize,
                     strockColor: Color(uiColor: .iCinemaYellowColor),
                     strockSpacing: 5)
        .frame(width: .home.cinemas.imageSize.width, height: .home.cinemas.imageSize.height)
    }
    
    @ViewBuilder private func Location() -> some View {
        HStack {
            Image(systemName: UIImage.location)
                .resizable()
                .frame(width: 12, height: 12)
                .foregroundColor(Color(uiColor: .iCinemaYellowColor))
            
            Text("Cairo / 2.3km")
                .font(Font(UIFont.caption1))
                .lineLimit(1)
        }

    }
    
    @ViewBuilder private func rate() -> some View {
        HStack(spacing: 5) {
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: 10, height: 10)
                .foregroundColor(Color(uiColor: .iCinemaYellowColor))
            
            // MARK: - Rate
            Text("\(cinema.averageRate ?? 0)/10")
                .font(Font(UIFont.caption1))
                .foregroundColor(.gray)
        }
    }
    
    @ViewBuilder private func followButton() -> some View {
        ICinemaButtonView(title: followed ? .unfollow : .follow, type: .small) {
            followed.toggle()
            self.cinemaFollowing.update(id: self.cinema.id)
            self.cinemaFollowing.request { response in
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
        .SPAlert(isPresent: $showAlert, message: alertMessage)

    }
}

//struct CinemaCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        CinemaCellView(cinema: Cinema( id:1,
//                                       
//                                       logo:"http://localhost:8000/defaults/default.png",
//                                       cover:"http://localhost:8000/defaults/default.png",
//                                       name:"Elnora Koelpin",
//                                       following:false,
//                                       averageRate:0,
//                                       countFollow: 5,
//                                       address:"361 Rodolfo Locks\nJanickstad, KY 69835",
//                                       distance:"36.51km")
//                       
//        )
//    }
//}
