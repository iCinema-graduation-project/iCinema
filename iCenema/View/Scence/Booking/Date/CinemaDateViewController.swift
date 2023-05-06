//
//  CinemaDateViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 26/03/2023.
//

import UIKit
import MakeConstraints

class CinemaDateViewController: ICinemaViewController {

    var viewModel = CinemaDateViewModel()
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TabBarViewModel.shared.hide()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addStepperView()
        
        guard let userInfo = userInfo, let movieID = userInfo["movieID"] as? Int else { return }
        self.makeNetworkRequest(with: movieID)
    }
    
    private func makeNetworkRequest(with movieID: Int) {
        self.viewModel.updateParamenter(with: movieID)
        self.viewModel.service.request { response in
            if let value = response.value {
                self.viewModel.inject(with: value.dates)
                self.updateUI()
            }else {
                self.handelError(response.error)
            }
        }

    }

    // MARK: - Update UI
    private func updateUI() {
        let cinemaDateView = CinemaDateView(view: self).hostigView()
 
        view.addSubview(cinemaDateView)
        cinemaDateView.fillXSuperViewConstraints()
        cinemaDateView.makeConstraints(topAnchor: view.safeAreaLayoutGuide.topAnchor,
                                       bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor)
    }
    


}
