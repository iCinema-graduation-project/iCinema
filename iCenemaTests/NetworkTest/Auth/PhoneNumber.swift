//
//  PhoneNumber.swift
//  iCinemaTests
//
//  Created by Ahmed Yamany on 23/04/2023.
//

import XCTest
@testable import iCinema
import Combine

final class PhoneNumber: XCTestCase {
    
    var service: PhoneNumberService!
    internal var cancellableSet: Set<AnyCancellable> = []

    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }


    func testLogin() {
        service = PhoneNumberService(phone: "01551608020")
        service.request()
            .sink { response in
                if let value = response.value {
                    XCTAssertEqual(value.key, "verify_phone")
                }
            }.store(in: &cancellableSet)
    }
    
    func testValidationError() {
        service = PhoneNumberService(phone: "")
        service.request()
            .sink { response in
                if let value = response.value {
                    XCTAssertEqual(value.key, "fail")
                }
            }.store(in: &cancellableSet)

    }

}
