//
//  HTTPError.swift
//  HTTPFramework
//
//  Created by Антон Савинов on 25.10.2020.
//

import Foundation

/// Describes `HTTP` error.
public struct HTTPError: Error {
    /// This enum describes possible errors
    /// that may be happened in `HTTP` layer.
    public enum Code {
        case badUrl
        case canceled
        case unkown
    }

    // MARK: - instance properties
    /// Describes error code. See more in `Code` enum.
    public let code: Code
    /// Represents request for which the current error happened.
    public let request: HTTPRequest
    /// Represents response for which the current error happened.
    public let response: HTTPResponse?
    /// Contains the raw error data.
    public let underlyingError: Error?
}
