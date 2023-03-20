//
//  CinemaProfileView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 05/03/2023.
//

import SwiftUI
import SwiftUITrackableScrollView

struct CinemaProfileView: View {
    let cinema: Cinema = Cinema(name: "Galaxy", followersCount: 63, rate: 3.5, ChairsCount: 430)
    let closeButtonAction: () -> Void
    @State private var scrollViewContentOffset = CGFloat(0)
    @State private var showCinemaImageInToolbarItem = false
    
    @State var scaleImageX: CGFloat = 1
    @State var scaleImageY: CGFloat = 1
    var body: some View {
        
        NavigationView {
            TrackableScrollView(.vertical, showIndicators: false, contentOffset: $scrollViewContentOffset) {
                VStack {
                    CinemaProfileHeaderView(cinema: cinema)
                        .padding(.bottom)

                    CinemaProfileInformationView(cinema: cinema)

                    CinemaProfileSliderView(cinema: cinema)
                    
                    CinemaProfilePickerView(cinema: cinema)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(uiColor: .iCinemaBackgroundColor))
            .onChange(of: scrollViewContentOffset, perform: { value in
                
                if scrollViewContentOffset > CGFloat.cinemaProfile.cinemaImageHeight {
                    withAnimation {
                        showCinemaImageInToolbarItem = true
                    }
                }else {
                    withAnimation {
                        showCinemaImageInToolbarItem = false
                      
                    }
                }
            })
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.closeButtonAction()
                    } label: {
                        Image(systemName: "x.circle")
                            .foregroundColor(Color(uiColor: .iCinemaYellowColor))
                    }
                }
                ToolbarItem(placement: .principal) {
                    HStack{
                        Image("cinema")
                            .makeCircled(size: CGSize(width: 26, height: 26),
                                         strockColor: Color(uiColor: .iCinemaYellowColor),
                                         lineWidth: 0.7
                            )
                            .isHidden(!showCinemaImageInToolbarItem)
                    }
                }
            }
            
        }
    }
}

struct CinemaProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CinemaProfileView(closeButtonAction: {})
    }
}



