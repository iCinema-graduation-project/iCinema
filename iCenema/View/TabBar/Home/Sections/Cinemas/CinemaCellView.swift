//
//  CinemaCellView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 09/04/2023.
//

import SwiftUI

struct CinemaCellView: View {
    @State var followed: Bool = false
    var body: some View {
        VStack {
            VStack {
                HStack {
                    
                    Image("cinema")
                        .resizable()
                        .makeCircled(size: CGFloat.home.cinemas.imageSize,
                                     strockColor: Color(uiColor: .iCinemaYellowColor),
                                     strockSpacing: 5)
                        .frame(width: .home.cinemas.imageSize.width, height: .home.cinemas.imageSize.height)
                        
                }
                
                Text("Galaxy Cinema")
                    .font(Font(UIFont.footnote))
                
                // Cinema Location
                HStack {
                    Image(systemName: UIImage.location)
                        .resizable()
                        .frame(width: 12, height: 12)
                        .foregroundColor(Color(uiColor: .iCinemaYellowColor))
                    
                    Text("Cairo / 2.3km")
                        .font(Font(UIFont.caption1))
                }

                // Rate
                HStack(spacing: 5) {
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundColor(Color(uiColor: .iCinemaYellowColor))
                    
                    // MARK: - Rate
                    Text("6.1/10")
                        .font(Font(UIFont.caption1))
                        .foregroundColor(.gray)
                }
                
                ICinemaButtonView(title: .unfollow, type: .small) {
                    
                }
            }
            .foregroundColor(Color(uiColor: .iCinemaTextColor))
            .padding(.horizontal, .cell.padding.left)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: .iCinemaSecondBackgroudColor))

    }
}

struct CinemaCellView_Previews: PreviewProvider {
    static var previews: some View {
        CinemaCellView()
    }
}
