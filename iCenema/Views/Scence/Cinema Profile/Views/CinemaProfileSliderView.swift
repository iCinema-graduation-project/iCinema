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
                ForEach(0..<5) { i in
                    Image("hale")
                        .resizable()
                        .frame(width: .cinemaProfile.sliderSize.width, height: .cinemaProfile.sliderSize.height)
                }
            }
        }
            .frame(width: .cinemaProfile.sliderSize.width, height: .cinemaProfile.sliderSize.height)
            .overlay {
                Rectangle()
                    .stroke(Color(uiColor: .iCinemaYellowColor), lineWidth: 1)
                    .frame(width: .cinemaProfile.sliderSize.width + 10,
                           height: .cinemaProfile.sliderSize.height + 10)
            }
    }
}
