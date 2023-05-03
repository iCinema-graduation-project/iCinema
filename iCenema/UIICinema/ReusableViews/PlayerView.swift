//
//  PlayerView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 01/05/2023.
//

import SwiftUI
import UIKit
import AVKit

class PlayerViewModel: ObservableObject {
    
    let id = UUID()
    
    @Published var player: AVPlayer? // can be changable depending on modified URL, etc.
    init(url: URL) {
        self.player = AVPlayer(url: url)
    }
    
    
    static func == (lhs: PlayerViewModel, rhs: PlayerViewModel) -> Bool {
        lhs.id == rhs.id
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
