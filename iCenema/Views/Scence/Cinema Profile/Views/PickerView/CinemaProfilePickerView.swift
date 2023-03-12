//
//  CinemaProfilePickerView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 07/03/2023.
//

import SwiftUI

struct CinemaProfilePickerView: View {
    let cinema: Cinema
    
    @State var pickerSelectedSectin: CinemaSections = .movies
    init(cinema: Cinema) {
        self.cinema = cinema
        UISegmentedControl.appearance().selectedSegmentTintColor = .iCinemaYellowColor
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.iCinemaTextColorReverce,
                                                                .font: UIFont.callout
        ], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.font: UIFont.body], for: .normal)
    
    }
    var body: some View {
        Picker("Choose Secction", selection: $pickerSelectedSectin) {
            ForEach(CinemaSections.allCases, id: \.self) {
                Text($0.rawValue)
                    .font(Font(UIFont.title3))
            }
        }
        .pickerStyle(.segmented)
        .padding()
        
        ChosenSectionView(section: pickerSelectedSectin)
    }
}

enum CinemaSections: String, CaseIterable {
    case movies = "Movies"
    case reels = "Reels"
    case posts = "Posts"
}

struct ChosenSectionView: View {
    var section: CinemaSections
    var body: some View {
        switch section {
        case .movies:
            MoviesListView()
        case .reels:
            SelectedSectionView(selectedSecten: "Reels")
        case.posts:
            SelectedSectionView(selectedSecten: "Posts")
        }
    }
}



struct SelectedSectionView: View {
    var selectedSecten: String
    var body: some View {
        Text(selectedSecten)
    }
}
