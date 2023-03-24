//
//  ActivityIndicator.swift
//  iCinema
//
//  Created by Ahmed Yamany on 22/03/2023.
//

import UIKit
import Lottie

class ActivityIndicator: LottieAnimationView {
    let view = UIView()

    convenience init() {
        self.init(name: "ActivityIndicator")
    }
  
    override func play(completion: LottieCompletionBlock? = nil) {
        super.play(completion: completion)
        contentMode = .scaleAspectFill
        loopMode = .loop
    
        centerInSuperview()
        equalSizeConstraints(150)
        
        if let superview = superview {
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
