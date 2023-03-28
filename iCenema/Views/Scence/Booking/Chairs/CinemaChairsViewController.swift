//
//  CinemaChairsViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 25/03/2023.
//

import UIKit

class CinemaChairsViewController: ICinemaViewController {

    var viewModel = CinemaChairsViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cinemaChairs = CinemaChairsView()
            .environmentObject(viewModel)
        
        let cinemaChairsView = cinemaChairs.hostigView()
        
        view.addSubview(cinemaChairsView)
        cinemaChairsView.fillXSuperViewConstraints()
        cinemaChairsView.makeConstraints(topAnchor: view.safeAreaLayoutGuide.topAnchor,
                                          bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor)
        addStepperView()
        
        
        viewModel.buttonAction = {
            self.coordinator?.push()
        }
        
    }
    


}
