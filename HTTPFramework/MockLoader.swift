//
//  MockLoader.swift
//  HTTPFramework
//
//  Created by Anton Savinov on 03.11.2020.
//

import Foundation
import Combine

class MockLoader: HTTPLoading {

    public enum FakeResult {
        case success
        case badUrl
        case canceled
    }

    private let fakeResult: FakeResult

    init(fakeResult: FakeResult) {
        self.fakeResult = fakeResult
    }

    func load(request: HTTPRequest) -> AnyPublisher<HTTPResponse, HTTPError> {
        guard let url = request.url else {
            fatalError("Can't fetch url from HTTPRequest")
        }
        guard let response = HTTPURLResponse(url: url, statusCode: statusCode(),
                                             httpVersion: "1.1", headerFields: nil) else {
            fatalError("Can't create HTTPURLResponse")
        }
        if fakeResult == .success {
            let response = HTTPResponse(response: response, request: request, body: nil)
            return Result.Publisher(response).eraseToAnyPublisher()
        } else {
            let error = HTTPError(code: errorCode(), request: request, response: nil, underlyingError: nil)
            return Result.Publisher(error).eraseToAnyPublisher()
        }
    }
}

private extension MockLoader {
    func statusCode() -> Int {
        switch fakeResult {
        case .success:
            return 200
        case .badUrl:
            return 404
        case .canceled:
            return 9000
        }
    }

    func errorCode() -> HTTPError.Code {
        switch fakeResult {
        case .success:
            fatalError()
        case .badUrl:
            return .badUrl
        case .canceled:
            return .canceled
        }
    }
}
