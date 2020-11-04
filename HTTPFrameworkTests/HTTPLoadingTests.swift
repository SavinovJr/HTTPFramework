//
//  HTTPLoadingTests.swift
//  HTTPFrameworkTests
//
//  Created by Антон Савинов on 02.11.2020.
//

import XCTest
import Combine
@testable import HTTPFramework

class HTTPLoadingTests: XCTestCase {

    func testMockLoadingSuccessfull() throws {
        let mockLoader = MockLoader(fakeResult: .success)

        var request = HTTPRequest()
        request.host = "swapi.dev"
        request.path = "/api/people"

        let publisher = mockLoader.load(request: request)
        _ = publisher.sink { (result) in
            switch result {
            case .finished:
                XCTAssert(true)
            case .failure(let error):
                XCTAssertNil(error)
            }
        } receiveValue: { (response) in
            XCTAssertNotNil(response)
            XCTAssertEqual(response.request.host, "swapi.dev")
            XCTAssertEqual(response.request.path, "/api/people")
        }
    }

    func testMockLoadingWithBadUrl() throws {
        let mockLoader = MockLoader(fakeResult: .badUrl)

        var request = HTTPRequest()
        request.host = "swapi.dev"
        request.path = "/api/people"

        let publisher = mockLoader.load(request: request)
        _ = publisher.sink { (result) in
            switch result {
            case .finished:
                XCTAssert(true)
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssertTrue(error.code == .badUrl)
            }
        } receiveValue: { (response) in
            XCTAssertNotNil(response)
            XCTAssertEqual(response.request.host, "swapi.dev")
            XCTAssertEqual(response.request.path, "/api/people")
        }
    }
}
