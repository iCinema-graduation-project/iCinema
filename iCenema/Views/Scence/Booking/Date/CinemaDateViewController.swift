//
//  CinemaDateViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 26/03/2023.
//

import UIKit

class CinemaDateViewController: ICinemaViewController {

    var viewModel = CinemaDateViewModel()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TabBarViewModel.shared.hide()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addStepperView()

        let cinemaDateView = CinemaDateView()
            .environmentObject(viewModel)
            .hostigView()
 
        view.addSubview(cinemaDateView)
        cinemaDateView.fillXSuperViewConstraints()
        cinemaDateView.makeConstraints(topAnchor: view.safeAreaLayoutGuide.topAnchor,
                                       bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor)
        
        
        viewModel.dismissAction = {
            self.coordinator?.push()
        }
        
    }
    


}
