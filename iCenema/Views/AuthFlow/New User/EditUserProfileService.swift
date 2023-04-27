//
//  NewUserService.swift
//  iCinema
//
//  Created by Ahmed Yamany on 23/04/2023.
//

import UIKit
import Alamofire
import NetworkLayer

class EditUserProfileService: APIRequest {
    typealias DecodableType = EditUserProfile
    
    lazy var networkRequest: NetworkRequest = .init(endpoint: "update-account-data?_method=put", method: .post)
    
}
