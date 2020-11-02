//
//  HTTPResponseTests.swift
//  HTTPFrameworkTests
//
//  Created by Антон Савинов on 02.11.2020.
//

import XCTest
@testable import HTTPFramework

class HTTPResponseTests: XCTestCase {
    func testHttpResponseShouldBeEmpty() throws {
        let httpRequest = HTTPRequest()
        let httpResponse = HTTPResponse(response: HTTPURLResponse(), request: httpRequest, body: nil)
        XCTAssertTrue(httpResponse.request.body.isEmpty == httpRequest.body.isEmpty)
        XCTAssertTrue(httpResponse.request.headers == httpRequest.headers)
        XCTAssertTrue(httpResponse.request.host == httpRequest.host)
        XCTAssertTrue(httpResponse.request.method == httpRequest.method)
        XCTAssertTrue(httpResponse.request.path == httpRequest.path)
        XCTAssertTrue(httpResponse.status.rawValue == 200)
        XCTAssertNil(httpResponse.body)
    }
}
