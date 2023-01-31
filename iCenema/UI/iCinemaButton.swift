//
//  icinemaButton.swift
//  iCinema
//
//  Created by Ahmed Yamany on 27/01/2023.
//

import UIKit

class iCinemaButton: UIButton {
    init(title: String) {
        super.init(frame: .zero)
        sizeConstraints(width: 200, height: 40)
        backgroundColor = ColorManager.iCinema
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 10
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 1, height: 1)
        setTitle(title, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
