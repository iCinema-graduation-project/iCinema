//
//  MovieProfileView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 08/03/2023.
//

import SwiftUI
import SwiftUITrackableScrollView
import AVKit

struct MovieProfileView: View {

    let closeButtonAction: () -> Void
    @State private var scrollViewContentOffset = CGFloat(0)
    @State private var showCinemaImageInToolbarItem = false
    
    let playerModel = PlayerViewModel(url: URL(string: "https://bit.ly/swswift")!)
    
    var body: some View {
        NavigationView {
            TrackableScrollView(.vertical, showIndicators: false, contentOffset: $scrollViewContentOffset) {

                VStack(alignment: .center){
                    MovieListCellView(showButtons: false)
                    
                    HStack {
                        Text("English")
                            .font(.system(size: 12))
                            .padding(.horizontal)
                            .frame(height: 28)
                            .background(Color(uiColor: .iCinemaSecondBackgroudColor))
                            .cornerRadius(10)
                        
                        Text("2.45 h")
                            .font(.system(size: 12))
                            .padding(.horizontal)
                            .frame(height: 28)
                            .background(Color(uiColor: .iCinemaSecondBackgroudColor))
                            .cornerRadius(10)
                        
                        Text("+12")
                            .font(.system(size: 12))
                            .padding(.horizontal)
                            .frame(height: 28)
                            .background(Color(uiColor: .iCinemaSecondBackgroudColor))
                            .cornerRadius(10)
                    }

                    //
                    ICinemaButtonView(title: "Book Now", action: {
                        
                    })
                    .padding()
            
                    PlayerView(viewModel: playerModel)
                        .frame(height: 200)
                        .cornerRadius(20)
                }
                .padding(.horizontal)
            }
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
                        self.closeButtonAction()
                    } label: {
                        Image(systemName: "x.circle")
                            .foregroundColor(Color(uiColor: .iCinemaYellowColor))
                    }

                }
                ToolbarItem(placement: .principal) {
                    HStack{
                        Image("posterImage")
                            .makeCircled(size: CGSize(width: 26, height: 26),
                                         strockColor: Color(uiColor: .iCinemaYellowColor),
                                         lineWidth: 0.7
                            )
                            .isHidden(!showCinemaImageInToolbarItem)

                    }
                }
            }
            .onDisappear(){
                self.playerModel.player?.pause()
                self.playerModel.player = nil
            }

        }
    }
}


struct MovieProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MovieProfileView(closeButtonAction: {})
    }
}


class PlayerViewModel: ObservableObject {
    @Published var player: AVPlayer? // can be changable depending on modified URL, etc.
    init(url: URL) {
        self.player = AVPlayer(url: url)
    }
}

struct PlayerView: UIViewControllerRepresentable {
    
    // just thing wrapper, as intended
    var viewModel: PlayerViewModel

    
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = AVPlayerViewController()
        controller.player = viewModel.player
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) { }

}

