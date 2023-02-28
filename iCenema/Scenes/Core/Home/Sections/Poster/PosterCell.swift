//
//  HeaderCollectionViewCell.swift
//  iCinema
//
//  Created by Ahmed Yamany on 28/02/2023.
//

import UIKit

final class PosterCollectionViewCell: UICollectionViewCell {
    // MARK: - Views
    private let posterView: UIView = {
        let view = UIView()
        view.sizeConstraints(width: .homePoseterWidth, height: .homePosterHeight)
        return view
    }()
    
    private let viewButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.sizeConstraints(width: .buttonWidth, height: .buttonHeight)
        return button
    }()
    
    
    // MARK: - initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addPosterView()
        self.addViewButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //  MARK: - update ui
    private func addPosterView(){
        contentView.addSubview(posterView)
        posterView.centerXInSuperview()
        posterView.makeConstraints(topAnchor: contentView.topAnchor)
        posterView.backgroundColor = .red
        posterView.layer.cornerRadius = .viewCornerRadius
    }
    
    private func addViewButton() {
        contentView.addSubview(viewButton)
        viewButton.centerXInSuperview()
        viewButton.makeConstraints(bottomAnchor: contentView.bottomAnchor)
        viewButton.layer.cornerRadius = .buttonCornerRadius
    }
    
    
}

// MARK: - IdentifiableView
extension PosterCollectionViewCell:  IdentifiableView { }
