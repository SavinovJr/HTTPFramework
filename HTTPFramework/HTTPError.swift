//
//  HTTPError.swift
//  HTTPFramework
//
//  Created by Антон Савинов on 25.10.2020.
//

import Foundation

public struct HTTPError: Error {

    public let code: Code

    public let request: HTTPRequest

    public let response: HTTPResponse?

    public let underlyingError: Error?

    public enum Code {
        case badUrl
        case canceled
        case unkown
    }
}
