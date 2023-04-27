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
        label.centerYInSuperview()
        label.makeConstraints(leadingAnchor: leadingAnchor,
                              padding: UIEdgeInsets(top: 0, left: .view.spacing,
                                                    bottom: 0, right: 0))
        label.textAlignment = .left
        label.font = .title3
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    func setTitle(_ title: String) {
        self.label.text = title
    }
}
