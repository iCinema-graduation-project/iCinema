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
    
    var service: OTPService!
    internal var cancellableSet: Set<AnyCancellable> = []

    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }
    
    func testVerifyCode() {
        service = OTPService(phone: "01551608020", code: "123456")
        
        service.request()
            .sink { response in
                
            }.store(in: &cancellableSet)
        
    }

}
