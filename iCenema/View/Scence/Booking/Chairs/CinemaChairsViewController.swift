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
        addStepperView()
        
        guard let userInfo = userInfo,  let time = userInfo["time"] as? Time else { return }
        print(time)
        let cinemaChairs = CinemaChairsView()
            .environmentObject(viewModel)
        
        let cinemaChairsView = cinemaChairs.hostigView()
        
        view.addSubview(cinemaChairsView)
        cinemaChairsView.fillXSuperViewConstraints()
        cinemaChairsView.makeConstraints(topAnchor: view.safeAreaLayoutGuide.topAnchor,
                                          bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor)
        
        
        viewModel.dismissAction = {
            self.coordinator?.push()
        }
        
    }
    


}
