//
//  CinemaCellView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 09/04/2023.
//

import SwiftUI

struct CinemaCellView: View {
    let cinema: Cinema
    
    @State var followed: Bool = false
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    AsyncImage(url: URL(string: cinema.logo)) { image in
                        image
                            .resizable()
                            .makeCircled(size: CGFloat.home.cinemas.imageSize,
                                         strockColor: Color(uiColor: .iCinemaYellowColor),
                                         strockSpacing: 5)

                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: .home.cinemas.imageSize.width, height: .home.cinemas.imageSize.height)
                        
                }
                
                Text(cinema.name)
                    .font(Font(UIFont.footnote))
                    .lineLimit(1)

                
                // Cinema Location
                HStack {
                    Image(systemName: UIImage.location)
                        .resizable()
                        .frame(width: 12, height: 12)
                        .foregroundColor(Color(uiColor: .iCinemaYellowColor))
                    
                    Text("Cairo / 2.3km")
                        .font(Font(UIFont.caption1))
                        .lineLimit(1)
                }

                // Rate
                HStack(spacing: 5) {
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundColor(Color(uiColor: .iCinemaYellowColor))
                    
                    // MARK: - Rate
                    Text("\(cinema.averageRate)/10")
                        .font(Font(UIFont.caption1))
                        .foregroundColor(.gray)
                }
                
                ICinemaButtonView(title: followed ? .unfollow : .follow, type: .small) {
                    followed.toggle()
                }
            }
            .foregroundColor(Color(uiColor: .iCinemaTextColor))
            .padding(.horizontal, .cell.padding.left)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: .iCinemaSecondBackgroudColor))
        .onAppear {
            followed = cinema.following
        }

    }
}

struct CinemaCellView_Previews: PreviewProvider {
    static var previews: some View {
        CinemaCellView(cinema: Cinema( id:1,
                                       logo:"http://localhost:8000/defaults/default.png",
                                       cover:"http://localhost:8000/defaults/default.png",
                                       name:"Elnora Koelpin",
                                       following:false,
                                       averageRate:0,
                                       address:"361 Rodolfo Locks\nJanickstad, KY 69835",
                                       distance:"36.51km"))
    }
}
