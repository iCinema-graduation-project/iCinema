//
//  NewUserService.swift
//  iCinema
//
//  Created by Ahmed Yamany on 23/04/2023.
//

import Foundation

class NewUserService: APIRequest {
    typealias DecodableType = NewUser
    
    var networkRequest: Request = .init(endpoint: "update-account-data?_method=put", method: .put)

    
    init()  {
        
    }
    
}
