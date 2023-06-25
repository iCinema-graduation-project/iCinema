//
//  PaymentMethodViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 16/04/2023.
//

import UIKit
import MakeConstraints

final class PaymentMethodViewController: ICinemaViewController {
    
    let viewModel = PaymentMethodViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let timeId = userInfo?["timeId"] as? Int, let seatsIds = userInfo?["seatsId"] as? [Int]  else { return }
        viewModel.service.networkRequest.update(parameters: ["time_view_id": timeId, "seats_ids": seatsIds])
        
        addStepperView()
        let paymentMthodView = PaymentMehodView()
            .environmentObject(viewModel)
            .hostigView()
        
        view.addSubview(paymentMthodView)
        paymentMthodView.fillXSuperViewConstraints()
        paymentMthodView.makeConstraints(topAnchor: view.safeAreaLayoutGuide.topAnchor,
                                         bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor)
        
        
        viewModel.dismissAction = {
            self.coordinator?.push()
        }
    }
}
