//
//  HTTPRequest.swift
//  HTTPFramework
//
//  Created by Anton Savinov on 25.10.2020.
//

import Foundation

/// This struct describes request message in HTTP Protocol
public struct HTTPRequest {
    // MARK: - instance properties

    private var urlComponents = URLComponents()
    /// Represents HTTP method. See all methods in `HTTPMethod`.
    /// By default, here is used `GET` method.
    public var method: HTTPMethod = .get
    /// Represents headers of request message.
    public var headers: [String: String] = [:]
    /// Represents body of request message.
    /// By defaults, here is used `EmptyBody`. See all kind of bodies in `HTTPBody`.
    public var body: HTTPBody = EmptyBody()

    // MARK: - initialization

    /// Initialization of request maessage of HTTP Protocol
    public init() {
        urlComponents.scheme = "https"
    }
}

// MARK: - Extension of `HTTP` request. Provides setters and getters.
public extension HTTPRequest {
    /// Represents scheme of request message.
    /// By default, if scheme wasn't initialized then `https` will be used.
    var scheme: String {
        urlComponents.scheme ?? "https"
    }
    ///  host for request message. For ex. `google.com`
    var host: String? {
        get {
            urlComponents.host
        }
        set {
            urlComponents.host = newValue
        }
    }
    /// Represents path of request message.
    /// In address `google.com/maps` `/maps` is path.
    var path: String {
        get {
            urlComponents.path
        }
        set {
            urlComponents.path = newValue
        }
    }
    /// Provides `URL` of request message
    var url: URL? {
        urlComponents.url
    }
}
