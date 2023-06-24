//
//  CinemaProfileView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 05/03/2023.
//

import SwiftUI
import SwiftUITrackableScrollView

struct CinemaProfileView: View {
  
    @EnvironmentObject var viewModel: CinemaProfileViewModel

    var body: some View {
        ProfileView(profileViewDelegate: viewModel, imageUrl: viewModel.logo) {
            
            VStack(spacing: .view.spacing) {
                
                CinemaProfileHeaderView()
                    .environmentObject(viewModel)
                
                CinemaProfileInformationView()
                    .environmentObject(viewModel)
                
                CinemaProfileSliderView()
                    .environmentObject(viewModel)
                
                CinemaProfilePickerView()
                    .environmentObject(viewModel)
                
                HStack { }
                    .frame(height: .supplementaryHeight)
                
            }
        }
    }
}



