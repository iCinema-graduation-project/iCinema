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


protocol OTPViewModelType {
    associatedtype AssocType: APIRequest
    
    var otp: OTPString { get set }
    var service: AssocType { get set}
    func textField(didChanged text: String, at index: Int)
    func updateNetworkRequestParameters(with phone: String)
}

// MARK: - View Model
//
class OTPViewModel: OTPViewModelType {
    
    var otp = OTPString(count: 6)
    var service: some APIRequest = OTPService()
    
    func textField(didChanged text: String, at index: Int) {
        
        if !text.isEmpty {
            self.otp.add(charachter: text, at: index)
        }else{
            self.otp.removeCharachter(at: index)
        }
        
    }
    
    func updateNetworkRequestParameters(with phone: String) {
        self.service.networkRequest.parameters = [
            "country_code": "20",
            "phone": phone,
            "code": self.otp.code,
            "device_id": deviceID,
            "device_type": "ios"
        ]
    }
    
    
}




