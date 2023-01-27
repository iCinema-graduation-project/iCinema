//
//  ViewController.swift
//  iCenema
//
//  Created by Ahmed Yamany on 27/01/2023.
//

import UIKit
import SwiftUI


class ViewController: UIViewController {
    // MARK: - Properties
    var backgroundView: UIView = UIView()

    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackgroundView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backgroundView.frame = self.view.bounds
    }

}

// MARK: - Add background view
//
extension ViewController {
    private func addBackgroundView(){
        let hostingController = UIHostingController(rootView: BackgroundView())
        guard let backgroundView = hostingController.view else { return}
        self.backgroundView = backgroundView
        self.view.addSubview(backgroundView)
    }
}
