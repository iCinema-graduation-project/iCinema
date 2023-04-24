//
//  NewUserViewModel.swift
//  iCinema
//
//  Created by Ahmed Yamany on 10/02/2023.
//

import Foundation
import Combine

class NewUserViewModel: CancellableViewModel {
    
    var cancellableSet: Set<AnyCancellable> = []
    let service = NewUserService()
    
}
