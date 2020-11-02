//
//  HTTPRequestTests.swift
//  HTTPFrameworkTests
//
//  Created by Антон Савинов on 02.11.2020.
//

import XCTest
@testable import HTTPFramework

class HTTPRequestTests: XCTestCase {
    func testHTTPRequestShouldBeInitializedWithEmpty() throws {
        let request = HTTPRequest()
        XCTAssertTrue(request.method == .get)
        XCTAssertTrue(request.headers.isEmpty == true)
        XCTAssertTrue(request.body is EmptyBody)
        XCTAssertTrue(request.scheme == "https")
        XCTAssertNil(request.host)
        XCTAssertNotNil(request.path)
    }

    func testHTTPRequestShouldBeInitializedWithNonEmptyBody() throws {
        var request = HTTPRequest()
        request.body = FormBody(queryItems: [URLQueryItem(name: "parameter", value: "1")])
        XCTAssertNotNil(request.body)
    }

    func testHTTPRequestShouldBeInitializedWithNonEmptyHostAndPath() throws {
        var request = HTTPRequest()
        request.host = "google.com"
        request.path = "/images"
        XCTAssertEqual(request.host, "google.com")
        XCTAssertEqual(request.path, "/images")
    }
}
