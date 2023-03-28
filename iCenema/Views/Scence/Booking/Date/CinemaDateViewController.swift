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
        
        let cinemaDateView = CinemaDateView()
            .environmentObject(viewModel)
            .hostigView()
 
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
