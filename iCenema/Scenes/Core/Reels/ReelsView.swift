//
//  ReelsView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 02/03/2023.
//

import SwiftUI
import StoryUI

struct ReelsView: View {
    @State var isPresented: Bool = false
       @State var stories = [
           StoryUIModel(user: StoryUIUser(name: "Tolga İskender", image: "https://image.tmdb.org/t/p/original/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg"), stories: [
               Story(mediaURL: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4", date: "30 min ago", type: .video),
               Story(mediaURL: "https://image.tmdb.org/t/p/original//pThyQovXQrw2m0s9x82twj48Jq4.jpg", date: "1 hour ago", type: .image),
               Story(mediaURL: "https://image.tmdb.org/t/p/original/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg", date: "12 hour ago", type: .image)
           ]),
           StoryUIModel(user: StoryUIUser(name: "Jhon Doe", image: "https://image.tmdb.org/t/p/original//pThyQovXQrw2m0s9x82twj48Jq4.jpg"), stories: [
               Story(mediaURL: "https://picsum.photos/id/237/200/300", date: "12 hour ago", type: .image),
               Story(mediaURL: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4", date: "30 min ago", type: .video)
           ]),
       ]
    var body: some View {
        NavigationView {
            Button {
                isPresented = true
            } label: {
                Text("Show")
            }
            .fullScreenCover(isPresented: $isPresented) {
                StoryView(stories: stories,
                          isPresented: $isPresented)
                
            }
        }
    }
}

struct ReelsView_Previews: PreviewProvider {
    static var previews: some View {
        ReelsView()
    }
}
