//
//  NewUserService.swift
//  iCinema
//
//  Created by Ahmed Yamany on 23/04/2023.
//

import Foundation
import Alamofire

class EditUserProfileService: APIRequest {
    typealias DecodableType = EditUserProfile
    
    lazy var networkRequest: Request = .init(endpoint: "update-account-data?_method=put",
                                        method: .put,
                                        parameters: parameters)
    let parameters: Parameters
    init(parameters: Parameters) {
        self.parameters = parameters
    }
    
}
