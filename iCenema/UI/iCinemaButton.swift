//
//  icinemaButton.swift
//  iCinema
//
//  Created by Ahmed Yamany on 27/01/2023.
//

import UIKit

class iCinemaButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        sizeConstraints(width: 200, height: 40)
        backgroundColor = ColorManager.iCinema
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 15
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
