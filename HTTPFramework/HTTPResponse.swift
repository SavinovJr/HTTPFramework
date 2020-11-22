//
//  HTTPResponse.swift
//  HTTPFramework
//
//  Created by Антон Савинов on 25.10.2020.
//

import Foundation

/// Represents `HTTP` response message.
public struct HTTPResponse {
    // MARK: - instance properties
    private let response: HTTPURLResponse

    /// Request message.
    public let request: HTTPRequest
    /// Body of response message
    public let body: Data?

    // MARK: - initialization

    /// Constructs `HTTP` response message using the next input parameters.
    ///
    /// - Parameters:
    ///   - response: The response from server.
    ///   - request: The request that was sent to server.
    ///   - body: The binary data that come from server.
    /// - Returns: The `HTTP` response message.
    init(response: HTTPURLResponse, request: HTTPRequest, body: Data?) {
        self.response = response
        self.request = request
        self.body = body
    }
}

// MARK: - Extension of `HTTP` response. Provides getters.
public extension HTTPResponse {
    /// Desribes status of response message. See more in `HTTPStatus`.
    var status: HTTPStatus {
        HTTPStatus(rawValue: response.statusCode)
    }

    /// Represents the localized message based on status code.
    var message: String {
        HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
    }

    /// Returs all headers that are in `HTTP` response message.
    var headers: [AnyHashable: Any] {
        response.allHeaderFields
    }
}
