//
//  PaymentMethodViewModel.swift
//  iCinema
//
//  Created by Ahmed Yamany on 16/04/2023.
//

import SwiftUI


class PaymentMethodViewModel: ProfileViewDelegate {
    var dismissAction: (() -> Void) = {}
    
    
    @Published var paymentMethod: PaymentMethod = .creditCard
    
    @Published var isCreditCard: Bool = true {
        didSet {
            if isCreditCard {
                paymentMethod = .creditCard
                isEWallet = false
                isICinemaWallet = false
            }
            if !isCreditCard && !isEWallet && !isICinemaWallet{ paymentMethod = .none}

        }
    }
    @Published var isEWallet: Bool = false {
        didSet {
            if isEWallet {
                paymentMethod = .eWallet
                isCreditCard = false
                isICinemaWallet = false
            }
            if !isCreditCard && !isEWallet && !isICinemaWallet{ paymentMethod = .none}

        }
    }
    @Published var isICinemaWallet: Bool = false {
        didSet {
            if isICinemaWallet {
                paymentMethod = .iCinemaWallet
                isCreditCard = false
                isEWallet = false
            }
            if !isCreditCard && !isEWallet && !isICinemaWallet{ paymentMethod = .none}
        }
    }
    
    
  
}
