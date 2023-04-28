//
//  OTP.swift
//  iCinemaTests
//
//  Created by Ahmed Yamany on 23/04/2023.
//

import XCTest
import Combine
@testable import iCinema

final class OTP: XCTestCase {
    
    var service = OTPService()
    
    func testValidCode() {
        service.networkRequest.update(parameters: ["phone": "01551608020", "code": "123456"])
                
        service.request { response in
            guard let _ = response.value else { XCTAssertNil(response.value); return }
        }
        
    }
    
    func testInValidCode() {
        service.networkRequest.update(parameters: ["phone": "01551608020", "code": "333"])
                
        service.request { response in
            guard let _ = response.error else { XCTAssertNil(response.value); return }
        }
        
    }

}
