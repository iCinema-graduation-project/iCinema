//
//  CinemaProfileSliderView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 06/03/2023.
//

import SwiftUI

struct CinemaProfileSliderView: View {
    @EnvironmentObject var viewModel: CinemaProfileViewPresenter

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.cinema?.images ?? [], id: \.id) { imageLink in
                        AsyncImage(url: URL(string: imageLink.image)) { image in
                            image
                                .resizable()
                                .frame(width: .cinemaProfile.sliderSize.width, height: .cinemaProfile.sliderSize.height)
                            
                        } placeholder: {
                            Color.gray
                        }

                    }
                }
                .transition(.scale)
//            }
                
        }
            .frame(width: .cinemaProfile.sliderSize.width, height: .cinemaProfile.sliderSize.height)
            .overlay {
                Rectangle()
                    .stroke(Color(uiColor: .iCinemaYellowColor), lineWidth: 1)
                    .frame(width: .cinemaProfile.sliderSize.width + 10,
                           height: .cinemaProfile.sliderSize.height + 10)
            }
//            .transition(.move(edge: .trailing))

    }
}
