//
//  ProfileService.swift
//  iCinema
//
//  Created by Ahmed Yamany on 26/04/2023.
//

import Foundation
import Combine
import Alamofire
import NetworkLayer

class ProfileFeatcher: APIRequest {
    typealias DecodableType = Profile
    
    var networkRequest: NetworkRequest = NetworkRequest(endpoint: "profile", method: .get)
    var anyCancellable = AnyCancellable({})
    
    func getProfile(_ completion: @escaping (DataResponse<DecodableType, NetworkError>) -> Void ) {
        anyCancellable = request().sink { response in
            completion(response)
        }
        
    }
    
    
}
