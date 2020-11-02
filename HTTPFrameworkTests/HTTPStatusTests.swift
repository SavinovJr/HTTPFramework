//
//  HTTPStatusTests.swift
//  HTTPFrameworkTests
//
//  Created by Антон Савинов on 02.11.2020.
//

import XCTest
@testable import HTTPFramework

class HTTPStatusTests: XCTestCase {
    func testSetHTTPStatus200() throws {
        let status = HTTPStatus(rawValue: 200)
        XCTAssertEqual(status.rawValue, 200)
    }

    func testSetHTTPStatus403() throws {
        let status = HTTPStatus(rawValue: 403)
        XCTAssertEqual(status.rawValue, 403)
    }

    func testSetHTTPStatus500() throws {
        let status = HTTPStatus(rawValue: 500)
        XCTAssertEqual(status.rawValue, 500)
    }
}
