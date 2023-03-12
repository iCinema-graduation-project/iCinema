//
//  MovieSectionHeader.swift
//  iCinema
//
//  Created by Ahmed Yamany on 28/02/2023.
//

import UIKit

final class MovieSectionHeader: UICollectionReusableView, IdentifiableView {
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.fillSuperviewConstraints(padding: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 5))
        label.textAlignment = .left
        label.text = "For You"
        label.font = .title3
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    func setTitle(_ title: String) {
        self.label.text = title
    }
}
