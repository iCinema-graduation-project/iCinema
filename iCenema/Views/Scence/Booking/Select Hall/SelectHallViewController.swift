//
//  SelectHallViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 27/03/2023.
//

import UIKit

class SelectHallViewController: ICinemaViewController {
    
    let viewModel = SelectHallViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addStepperView()
        
        let selecthallView = SelectHallView()
            .environmentObject(viewModel)
            .hostigView()
        
        view.addSubview(selecthallView)
        selecthallView.fillXSuperViewConstraints()
        selecthallView.makeConstraints(topAnchor: view.safeAreaLayoutGuide.topAnchor,
                                       bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor)
        
        viewModel.dismissAction = {
            self.coordinator?.push()
        }
        
    }
    
}
