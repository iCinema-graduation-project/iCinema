//
//  ActivityIndicator.swift
//  iCinema
//
//  Created by Ahmed Yamany on 22/03/2023.
//

import UIKit
import Lottie
import MakeConstraints

class ActivityIndicator: LottieAnimationView {
    static let shared = ActivityIndicator()
    
    let view = UIView()

    convenience init() {
        self.init(name: "ActivityIndicator")
    }
  
    override func play(completion: LottieCompletionBlock? = nil) {
        super.play(completion: completion)
        contentMode = .scaleAspectFill
        loopMode = .loop
    
        
        if let superview = UIApplication.shared.keyWindow?.rootViewController?.view {
            superview.addSubview(self)
            centerInSuperview()
            equalSizeConstraints(150)
            
            view.frame = superview.bounds
            superview.addSubview(view)
            view.backgroundColor = .darkGray
            view.alpha = 0.05
        }
    }
    
    override func stop() {
        super.stop()
        view.removeFromSuperview()
        removeFromSuperview()
        
    }
    
    
}
