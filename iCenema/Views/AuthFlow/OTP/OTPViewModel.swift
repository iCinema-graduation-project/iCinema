//
//  OTPViewModel.swift
//  iCinema
//
//  Created by Ahmed Yamany on 06/02/2023.
//

import UIKit
import Alamofire

// MARK: - view model protocols
//
protocol OTPViewModelInput {
    func textField(didChanged text: String, at index: Int)
}

// MARK: - View Model
//
class OTPViewModel: APIRequest {
    typealias Response = Countries
    var endpoint: String = "all_countries.php"
    var parameters: Alamofire.Parameters? = nil
    var requestMethod: HTTPMethod = .get
    
    private(set) var otp = OTPString(count: 5)
}

// MARK: - View Model input
//
extension OTPViewModel: OTPViewModelInput {
    func textField(didChanged text: String, at index: Int) {
        let textIsNotEmpty = !text.isEmpty
        if textIsNotEmpty {
            self.otp.add(charachter: text, at: index)
        }else{
            self.otp.removeCharachter(at: index)
        }
        print(self.otp.code)
    }
}


