//
//  HTTPMethodTests.swift
//  HTTPFrameworkTests
//
//  Created by Антон Савинов on 02.11.2020.
//

import XCTest
@testable import HTTPFramework

class HTTPMethodTests: XCTestCase {
    func testSetHTTPMethodGet() throws {
        let getMethod = HTTPMethod(rawValue: "GET")
        XCTAssertTrue(getMethod.rawValue == "GET")
    }

    func testSetHTTPMethodPost() throws {
        let postMethod = HTTPMethod(rawValue: "POST")
        XCTAssertTrue(postMethod.rawValue == "POST")
    }

    func testSetHTTPMethodPut() throws {
        let putMethod = HTTPMethod(rawValue: "PUT")
        XCTAssertTrue(putMethod.rawValue == "PUT")
    }

    func testSetHTTPMethodDelete() throws {
        let deleteMethod = HTTPMethod(rawValue: "DELETE")
        XCTAssertTrue(deleteMethod.rawValue == "DELETE")
    }
}
