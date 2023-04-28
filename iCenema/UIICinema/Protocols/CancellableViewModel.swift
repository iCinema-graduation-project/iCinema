//
//  CancellableViewModel.swift
//  iCinema
//
//  Created by Ahmed Yamany on 25/04/2023.
//

import Foundation
import Combine


protocol CancellableViewModel {
    var cancellableSet: Set<AnyCancellable> { get set }
}

extension CancellableViewModel {
    mutating func cancelAllRequests() {
        self.cancellableSet.forEach { $0.cancel() }
        self.cancellableSet.removeAll()
    }
}
