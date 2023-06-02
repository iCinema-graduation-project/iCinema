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

    func testEmptyOTP() {
        XCTAssertTrue(viewModel.otp.isEmpty)
    }
    func testValidOTP() {
        viewModel.textField(didChanged: "1", at: 0)
        viewModel.textField(didChanged: "2", at: 1)
        viewModel.textField(didChanged: "3", at: 2)
        viewModel.textField(didChanged: "4", at: 3)
        viewModel.textField(didChanged: "5", at: 4)
        viewModel.textField(didChanged: "6", at: 4)
        XCTAssertFalse(viewModel.otp.isEmpty)
    }
    func testInvalidOTP() {
        viewModel.textField(didChanged: "1", at: 0)
        viewModel.textField(didChanged: "2", at: 1)
        viewModel.textField(didChanged: "3", at: 2)
        XCTAssertTrue(viewModel.otp.isEmpty)
    }
    func testTextFieldDidChangedWithInvalidIndex() {
        viewModel.textField(didChanged: "1", at: 6)
        XCTAssertEqual(viewModel.otp.code, "")
    }

}
