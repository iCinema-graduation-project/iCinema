//
//  ProfileView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 28/03/2023.
//

import SwiftUI
import SwiftUITrackableScrollView


struct ProfileView<Content: View>: View {
    var profileViewDelegate: any ProfileViewDelegate
    var image: Image
    var content: () -> Content
    
    
    @State private var scrollViewContentOffset = CGFloat(0)
    @State private var showCinemaImageInToolbarItem = false
    
    var body: some View {
        
        NavigationView {
            TrackableScrollView(.vertical,
                                showIndicators: false,
                                contentOffset: $scrollViewContentOffset,
                                content: content)
                                
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(uiColor: .iCinemaBackgroundColor))
            
            .onChange(of: scrollViewContentOffset, perform: { value in

                if scrollViewContentOffset > CGFloat.cinemaProfile.imageSize.height {
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
                        profileViewDelegate.dismissAction()
                    } label: {
                        Image(systemName: "x.circle")
                            .foregroundColor(Color(uiColor: .iCinemaYellowColor))
                    }
                }
                ToolbarItem(placement: .principal) {
                    HStack{
                        image
                            .makeCircled(size: CGFloat.profile.imageSize,
                                         strockColor: Color(uiColor: .iCinemaYellowColor),
                                         lineWidth: .profile.strockLineWidth
                            )
                            .isHidden(!showCinemaImageInToolbarItem)
                    }
                }
            }
            
        }
    }
}





