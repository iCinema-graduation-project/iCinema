//
//  OTPViewModel.swift
//  iCinema
//
//  Created by Ahmed Yamany on 06/02/2023.
//

import UIKit
import Combine
import Alamofire
import NetworkLayer



// MARK: - View Model
//
class OTPViewModel: CancellableViewModel {
    
    private(set) var otp = OTPString(count: 6)
    
    var cancellableSet: Set<AnyCancellable> = []
    
    func textField(didChanged text: String, at index: Int) {
        let textIsNotEmpty = !text.isEmpty
        if textIsNotEmpty {
            self.otp.add(charachter: text, at: index)
        }else{
            self.otp.removeCharachter(at: index)
        }
    }
    
    public func request(phone: String, _ completion: @escaping (Result<VerifyCode, NetworkError>) -> Void ) {
        let service = OTPService(phone: phone, code: self.otp.code)
        
        service.request()
            .sink { response in
                if let error = response.error {
                    completion(.failure(error))
                } else if let value = response.value {
                    completion(.success(value))
                } else {
                    completion(.failure(.other))
                }
            }
            .store(in: &cancellableSet)
        
    }
    
    public func reset() {
        self.otp.reset()
    }
    
}




