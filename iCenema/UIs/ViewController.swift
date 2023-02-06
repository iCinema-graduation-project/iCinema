//
//  ViewController.swift
//  iCinema
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
        configureNavegationControllar()
        
        self.backgroundView = UIBackgroundView()
        self.view.addSubview(self.backgroundView)
  
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backgroundView.frame = self.view.bounds
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Helper Functions
    //
    private func configureNavegationControllar() {
        navigationController?.navigationBar.tintColor = ColorManager.textColor
        navigationItem.backButtonTitle = ""
        
        // change navigarionBar back button Image
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "chevron.backward.square")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "chevron.backward.square")
    }
    
    public func addNavigationTitleView(title: String) {
        let label = UILabel()
        label.text = title
        label.textColor = ColorManager.textColor
        navigationItem.titleView = label
    }
    
    public func addNavigationTitleView(view: UIView) {
        navigationItem.titleView = view
    }

}

