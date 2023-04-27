//
//  CinemaCell.swift
//  iCinema
//
//  Created by Ahmed Yamany on 01/03/2023.
//

import UIKit
import SwiftUI
import UIICinema

class CinemaCell: UICollectionViewCell, IdentifiableView {
   
    // MARK: - intializers
    //
    override init(frame: CGRect) {
        super.init(frame: frame)

        let cinemaCellView = CinemaCellView().hostigView()
        contentView.addSubview(cinemaCellView)
        cinemaCellView.fillSuperviewConstraints()
        
        layer.cornerRadius = .view.cornerRadius
        layer.masksToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
   
}