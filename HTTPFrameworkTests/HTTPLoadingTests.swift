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
    func testMethod() throws {
        let loader: HTTPLoading = URLSession.shared

        var request = HTTPRequest()
        request.host = "swapi.dev"
        request.path = "/api/people"

        let semaphore = semaphore_t()
        var success = true
        let publisher = loader.load(request: request)
        let cancelable = publisher
            .sink { (result) in
                switch result {
                case .finished:
                    success = true
                    semaphore_signal(semaphore)
                case .failure(let error):
                    print(error)
                    success = false
                    semaphore_signal(semaphore)
                }
            } receiveValue: { (response) in
                XCTAssertNotNil(response)
                success = true
            }

        semaphore_wait(semaphore)
        XCTAssertTrue(success)
        cancelable.cancel()
    }
}
