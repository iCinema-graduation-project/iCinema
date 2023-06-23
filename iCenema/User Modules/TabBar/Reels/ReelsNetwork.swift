//
//  ReelsNetwork.swift
//  iCinema
//
//  Created by Ahmed Yamany on 23/06/2023.
//

import Foundation
import Alamofire

class ReelsNetwork {
    
    var network: NetworkLayer<Reels> = .init(endpoint: "reels/get-reel", method: .get)
    
    let apiUrl = URL(string: "http://icinema.live/api/v1/reels/get-reel")!
    lazy var request = URLRequest(url: apiUrl)
    
    func getData() async throws -> Void{
        let (data, response) = try await URLSession.shared.data(for: request)
        
    }
    
    
    
    
    

}
