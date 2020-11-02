//
//  HTTPError.swift
//  HTTPFrameworkTests
//
//  Created by Антон Савинов on 02.11.2020.
//

import XCTest
@testable import HTTPFramework

class HTTPErrorTests: XCTestCase {
    func testHttpErrorShouldBeInitializedWithEmpty() throws {
        let httpRequest = HTTPRequest()
        let httpResponse = HTTPResponse(response: HTTPURLResponse(), request: httpRequest, body: nil)
        let httpError = HTTPError(code: .unkown, request: httpRequest, response: httpResponse, underlyingError: nil)

        XCTAssertNotNil(httpError.request)
        XCTAssertNotNil(httpError.response)
        XCTAssertNil(httpError.underlyingError)
        XCTAssertTrue(httpError.code == .unkown)
    }
}
