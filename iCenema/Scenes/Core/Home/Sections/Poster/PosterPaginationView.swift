//
//  PosterSupplementaryView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 28/02/2023.
//

import UIKit

class PosterPaginationView: UICollectionReusableView, IdentifiableView {
    
    lazy var pageController: UIPageControl = {
        let pageController = UIPageControl()
        pageController.currentPageIndicatorTintColor = .iCinemaYellowColor
        pageController.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        return pageController
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubview(pageController)
        pageController.centerInSuperview()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    public func setNumberOfPages(_ number: Int) {
        pageController.numberOfPages = number
    }
    
    public func selectPage(at index: Int) {
        self.pageController.currentPage = index
    }
    
}
