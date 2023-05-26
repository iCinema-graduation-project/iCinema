//
//  CinemaProfileSliderView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 06/03/2023.
//

import SwiftUI

struct CinemaProfileSliderView: View {
    @EnvironmentObject var viewModel: CinemaProfileViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(viewModel.images, id: \.id) { imageLink in
                    ICinemaAsyncImage(url: URL(string: imageLink.image)) { image in
                        image
                            .resizable()
                        
                    }
                    .frame(width: .cinemaProfile.sliderSize.width, height: .cinemaProfile.sliderSize.height)
                }
            }
                
        }
            .frame(width: .cinemaProfile.sliderSize.width, height: .cinemaProfile.sliderSize.height)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(uiColor: .iCinemaYellowColor), lineWidth: 1)
                    .frame(width: .cinemaProfile.sliderSize.width + 10,
                           height: .cinemaProfile.sliderSize.height + 10)
            }


    }
}
