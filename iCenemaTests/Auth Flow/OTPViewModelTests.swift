//
//  OTPViewModelTests.swift
//  iCinemaTests
//
//  Created by Ahmed Yamany on 10/03/2023.
//

import XCTest
@testable import iCinema

final class OTPViewModelTests: XCTestCase {

    var viewModel: OTPViewModel!

    override func setUpWithError() throws {
        viewModel = OTPViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testTextFieldDidChanged() {
        viewModel.textField(didChanged: "1", at: 0)
        XCTAssertTrue(viewModel.otp.isEmpty)
        
    }
  
    func testConfirmWithEmptyOTP() {
        viewModel.confirm { isOTPEmpty, isOTPValid in
            XCTAssertTrue(isOTPEmpty)
            XCTAssertFalse(isOTPValid)
        }
    }
    
    func testConfirmWithValidOTP() {
        viewModel.textField(didChanged: "1", at: 0)
        viewModel.textField(didChanged: "2", at: 1)
        viewModel.textField(didChanged: "3", at: 2)
        viewModel.textField(didChanged: "4", at: 3)
        viewModel.textField(didChanged: "5", at: 4)
        
        viewModel.confirm { isOTPEmpty, isOTPValid in
            XCTAssertFalse(isOTPEmpty)
            XCTAssertTrue(isOTPValid)
        }
    }
    
    func testConfirmWithInvalidOTP() {
        viewModel.textField(didChanged: "1", at: 0)
        viewModel.textField(didChanged: "2", at: 1)
        viewModel.textField(didChanged: "3", at: 2)
        
        viewModel.confirm { isOTPEmpty, isOTPValid in
            XCTAssertTrue(isOTPEmpty)
            XCTAssertFalse(isOTPValid)
        }
    }
    
    func testTextFieldDidChangedWithInvalidIndex() {
        viewModel.textField(didChanged: "1", at: 6)
        XCTAssertEqual(viewModel.otp.code, "")
    }

}
