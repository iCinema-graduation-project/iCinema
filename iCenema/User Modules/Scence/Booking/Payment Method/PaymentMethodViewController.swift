//
//  PaymentMethodViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 16/04/2023.
//

import UIKit

final class PaymentMethodViewController: ICinemaViewController {
    
    let viewModel = PaymentMethodViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
