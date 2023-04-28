//
//  PhoneViewModelTests.swift
//  iCinemaTests
//
//  Created by Ahmed Yamany on 08/02/2023.
//

import XCTest
import Combine
@testable import iCinema

final class PhoneViewModelTests: XCTestCase {
    
    var viewModel: PhoneViewModel!
    var cancellabelSet: Set<AnyCancellable> = []

    override func setUpWithError() throws {
        viewModel = PhoneViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testValidPhoneNumber() {
        let expectation = self.expectation(description: "Phone number is valid")
        
        viewModel.phoneNumber = "01234567890"
        
        viewModel.$isPhoneNumberValid.sink { isValid in
            XCTAssertTrue(isValid, "Phone number should be valid")
            expectation.fulfill()
        }.store(in: &cancellabelSet)
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testInvalidPhoneNumber() {
        let expectation = self.expectation(description: "Phone number is invalid")
        
        viewModel.phoneNumber = "112233445566"
        viewModel.$isPhoneNumberValid.sink { isValid in
            XCTAssertFalse(isValid, "Phone number should be invalid")
            expectation.fulfill()
        }
        .store(in: &cancellabelSet)
        
        waitForExpectations(timeout: 1, handler: nil)
    }

}
