//
//  HTTPResponse.swift
//  HTTPFramework
//
//  Created by Антон Савинов on 25.10.2020.
//

import Foundation

public struct HTTPResponse {
    private let response: HTTPURLResponse
    public let request: HTTPRequest
    public let body: Data?
}

public extension HTTPResponse {
    var status: HTTPStatus {
        HTTPStatus(rawValue: response.statusCode)
    }

    var message: String {
        HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
    }

    var headers: [AnyHashable: Any] {
        response.allHeaderFields
    }
}
