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
    var imageUrl: String?
    var ingnoreSaveArea: SafeAreaRegions = .keyboard
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
//                            .resizable()
//                            .frame(width: 15, height: 15)
                            .foregroundColor(Color(uiColor: .iCinemaYellowColor))
                            .padding(10)
                            .background(.thinMaterial)
                            .makeCircled(size: CGSize(width: 25, height: 25), strockColor: Color(uiColor: .iCinemaYellowColor))
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    HStack{
                        AsyncImage(url: URL(string: imageUrl ?? "")) { image in
                            image
                                .resizable()
                        } placeholder: {
                            Color.clear
                        }
                        .makeCircled(size: CGFloat.profile.imageSize,
                                     strockColor: Color(uiColor: .iCinemaYellowColor),
                                     lineWidth: .profile.strockLineWidth
                        )
                        .frame(width: .profile.imageSize.width, height: .profile.imageSize.height)
                        .isHidden(!showCinemaImageInToolbarItem)
                    }
                }
            }
            .ignoresSafeArea(ingnoreSaveArea)
        }
    }
    
    
 
    
}





