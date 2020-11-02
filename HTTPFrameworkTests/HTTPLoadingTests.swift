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

        
        _ = loader.load(request: request)
            .receive(on: DispatchQueue.main)
            .sink { (result) in
            switch result {
            case .finished:
                print("finished")
            case .failure(let error):
                print(error)
            }
        } receiveValue: { (response) in
            XCTAssertNotNil(response)
        }
        
        wait(for: [XCTestExpectation()], timeout: 60)
    }
}
