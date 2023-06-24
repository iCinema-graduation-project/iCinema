//
//  CinemaProfilePickerView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 07/03/2023.
//

import SwiftUI

enum CinemaSections: String, CaseIterable {
    case movies = "Movies"
//    case reels = "Reels"
//    case posts = "Posts"
}

struct CinemaProfilePickerView: View {
    @EnvironmentObject var viewModel: CinemaProfileViewModel
    
    @State var pickerSelectedSectin: CinemaSections = .movies
   
    var body: some View {
        VStack {
//            Picker("Choose Secction", selection: $pickerSelectedSectin) {
//                ForEach(CinemaSections.allCases, id: \.self) {
//                    Text($0.rawValue)
//                        .font(Font(UIFont.title3))
//                }
//            }
//            .pickerStyle(.segmented)
//            .padding(.horizontal)
            
            ChosenSectionView(section: pickerSelectedSectin)
                .environmentObject(viewModel)
        }
    }
}



struct ChosenSectionView: View {
    @EnvironmentObject var viewModel: CinemaProfileViewModel

    var section: CinemaSections
    var body: some View {
        switch section {
        case .movies:
            MoviesListView()
                .environmentObject(viewModel)
//        case .reels:
//            SelectedSectionView(selectedSecten: "Reels")
//        case.posts:
//            SelectedSectionView(selectedSecten: "Posts")
        }
    }
}



struct SelectedSectionView: View {
    var selectedSecten: String
    var body: some View {
        Text(selectedSecten)
    }
}
