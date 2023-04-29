//
//  MovieCell.swift
//  iCinema
//
//  Created by Ahmed Yamany on 28/02/2023.
//

import UIKit
import SwiftUI
class MovieCell: UICollectionViewCell, IdentifiableView {
    // MARK: - Views
    //
    
    // MARK: - initialization
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = .view.cornerRadius
        contentView.clipsToBounds = true
 
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    public func setup(with movie: Movie) {
        
        let movieCellView = MovieCellView(movie: movie).hostigView()
        contentView.addSubview(movieCellView)
        movieCellView.fillSuperviewConstraints()
       
    }
    
    
}
