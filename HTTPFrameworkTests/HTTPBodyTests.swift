//
//  HTTPBodyTests.swift
//  HTTPFrameworkTests
//
//  Created by Антон Савинов on 02.11.2020.
//

import XCTest
@testable import HTTPFramework

class HTTPBodyTests: XCTestCase {
    func testHttpEmptyBody() throws {
        let emptyBody = EmptyBody()
        XCTAssertTrue(emptyBody.isEmpty)
        XCTAssertTrue(emptyBody.additionalHeaders.isEmpty)
        XCTAssertTrue(try emptyBody.encodeData().isEmpty)
    }

    func testHttpDataBody() throws {
        let data = Data()
        let dataBody = DataBody(data: data)
        XCTAssertTrue(dataBody.isEmpty)
        XCTAssertTrue(dataBody.additionalHeaders.isEmpty)
        XCTAssertTrue(try dataBody.encodeData() == data)
    }

    func testHttpJsonBody() throws {
        let string = "Some string"
        let jsonBody = JSONBody(value: string)
        XCTAssertFalse(jsonBody.isEmpty)
        XCTAssertFalse(jsonBody.additionalHeaders.isEmpty)
        XCTAssertNotNil(try jsonBody.encodeData())
    }

    func testHttpFormBodyBody() throws {
        let formBody = FormBody(queryItems: [URLQueryItem(name: "parameter", value: "1")])
        XCTAssertFalse(formBody.isEmpty)
        XCTAssertFalse(formBody.additionalHeaders.isEmpty)
        XCTAssertNotNil(try formBody.encodeData())
    }
}
