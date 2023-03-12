//
//  MovieCellView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 11/03/2023.
//

import SwiftUI

struct MovieCellView: View {
    
    @State var bookmarked = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 5) {
                Image("posterImage")
                    .resizable()
                    .frame( height: .home.movies.imageHeight)
                    .cornerRadius(CGFloat.view.cornerRadius)
                    .shadow(color: Color(uiColor: .iCinemaYellowColor), radius: 1)
                  
                HStack {
                    Text("Black Adam")
                        .font(Font(UIFont.body))
                        .lineLimit(1)
                    Spacer()
                    Button {
                        bookmarked.toggle()
                    } label: {
                        Image(systemName: bookmarked ? "bookmark.fill" : "bookmark")
                            .resizable()
                            .frame(width: 12, height: 18)
                            .foregroundColor(Color(uiColor: .iCinemaYellowColor))
                    }

                    
                }
                // Ciname Name
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
                    Image(systemName: "location")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .foregroundColor(Color(uiColor: .iCinemaYellowColor))
                    
                    Text("Cairo / 2.3km")
                        .font(Font(UIFont.caption1))
                    
                }
                // Genre
       
                // MARK: - Genre
                Text("Action, Horror, Tragety")
                    .font(Font(UIFont.caption2))
                    .foregroundColor(.gray)
            

                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 12)
        }
        .frame(width: .home.movies.cellWidth, height: .home.movies.cellHeight)
        .background(Color(uiColor: .iCinemaSecondBackgroudColor))
    
    }
}

struct MovieCellView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCellView()
    }
}
