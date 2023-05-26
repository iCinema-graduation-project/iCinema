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



struct CinemaProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CinemaProfileViewModel()
        
        let cinema = Cinema(id: 16, logo: "http://icinema.live/defaults/default.png", cover: Optional("http://icinema.live/defaults/default.png"), name: "Kim Weber DDS", following: Optional(false), averageRate: Optional(0), countFollow: Optional(0), address: Optional("6215 Reese Harbors\nTerrymouth, TX 15158"), distance: nil, images: Optional([iCinema.CinemaImage(id: 16, image: "http://icinema.live/defaults/default.png"), iCinema.CinemaImage(id: 36, image: "http://icinema.live/defaults/default.png"), iCinema.CinemaImage(id: 56, image: "http://icinema.live/defaults/default.png")]), movies: Optional([iCinema.CinemaMovie(id: 16, image: "http://icinema.live/defaults/default.png", cover: "http://icinema.live/defaults/default.png", name: "Stephanie Grimes"), iCinema.CinemaMovie(id: 36, image: "http://icinema.live/defaults/default.png", cover: "http://icinema.live/defaults/default.png", name: "Issac Bradtke"), iCinema.CinemaMovie(id: 56, image: "http://icinema.live/defaults/default.png", cover: "http://icinema.live/defaults/default.png", name: "Evans Gulgowski"), iCinema.CinemaMovie(id: 76, image: "http://icinema.live/defaults/default.png", cover: "http://icinema.live/defaults/default.png", name: "Madge Keeling V"), iCinema.CinemaMovie(id: 96, image: "http://icinema.live/defaults/default.png", cover: "http://icinema.live/defaults/default.png", name: "Elmer Beier"), iCinema.CinemaMovie(id: 116, image: "http://icinema.live/defaults/default.png", cover: "http://icinema.live/defaults/default.png", name: "Darion Schiller"), iCinema.CinemaMovie(id: 136, image: "http://icinema.live/defaults/default.png", cover: "http://icinema.live/defaults/default.png", name: "Clint Pollich"), iCinema.CinemaMovie(id: 156, image: "http://icinema.live/defaults/default.png", cover: "http://icinema.live/defaults/default.png", name: "Dr. Antonia O\'Kon Jr."), iCinema.CinemaMovie(id: 176, image: "http://icinema.live/defaults/default.png", cover: "http://icinema.live/defaults/default.png", name: "Jennifer O\'Reilly"), iCinema.CinemaMovie(id: 196, image: "http://icinema.live/defaults/default.png", cover: "http://icinema.live/defaults/default.png", name: "Albertha Klocko")]))
        
        viewModel.updateModel(with: cinema)

        return CinemaProfileView()
            .environmentObject(viewModel)
    }
}
