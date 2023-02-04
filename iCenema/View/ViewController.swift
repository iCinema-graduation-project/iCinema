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
//        self.view.addSubview(self.backgroundView)
        view.backgroundColor =  UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        backgroundView.frame = self.view.bounds
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    // MARK: - Helper Functions
    //
    private func configureNavegationControllar() {
        navigationController?.navigationBar.tintColor = ColorManager.textColor
        navigationItem.backButtonTitle = ""
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
        
    }

}

