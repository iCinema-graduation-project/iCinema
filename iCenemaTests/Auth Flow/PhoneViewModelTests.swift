//
//  PhoneViewModelTests.swift
//  iCinemaTests
//
//  Created by Ahmed Yamany on 08/02/2023.
//

import XCTest
@testable import iCinema

final class PhoneViewModelTests: XCTestCase {
    
    var viewModel: PhoneViewModel!
    

    override func setUpWithError() throws {
        viewModel = PhoneViewModel(view: PhoneViewController())
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testValidPhoneNumber() {
            let expectation = self.expectation(description: "Phone number is valid")
            
            viewModel.output.onPhoneNumberChanged { (isValid) in
                XCTAssertTrue(isValid, "Phone number should be valid")
                expectation.fulfill()
            }
            
            viewModel.inputs.didChange(phoneNumber: "01234567890")
            
            waitForExpectations(timeout: 1, handler: nil)
        }
    
    func testInvalidPhoneNumber() {
            let expectation = self.expectation(description: "Phone number is invalid")
            
            viewModel.output.onPhoneNumberChanged { (isValid) in
                XCTAssertFalse(isValid, "Phone number should be invalid")
                expectation.fulfill()
            }
            
            viewModel.inputs.didChange(phoneNumber: "112233445566")
            
            waitForExpectations(timeout: 1, handler: nil)
        }

  

}
