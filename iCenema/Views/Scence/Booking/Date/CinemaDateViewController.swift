//
//  CinemaDateViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 26/03/2023.
//

import UIKit

class CinemaDateViewController: ICinemaViewController {

    var viewModel = CinemaDateViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cinemaDate = CinemaDateView()
            .environmentObject(viewModel)
        let cinemaDateView = cinemaDate.hostigView()
        
        view.addSubview(cinemaDateView)
        cinemaDateView.fillXSuperViewConstraints()
        cinemaDateView.makeConstraints(topAnchor: view.safeAreaLayoutGuide.topAnchor,
                                       bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor)
        addStepperView()
        
        
        
        viewModel.buttonAction = {
            self.coordinator?.push()
        }
        
    }
    


}
