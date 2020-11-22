//
//  HTTPBody.swift
//  HTTPFramework
//
//  Created by Anton Savinov on 02.11.2020.
//

import Foundation

/// `HTTP` body protocol.
public protocol HTTPBody {
    /// Returns true if body is empty. Otherwise, false
    var isEmpty: Bool { get }
    /// Returns the additional headers.
    /// When we encode a value as JSON,
    /// then we’d like a way to specify the Content-Type: application/json header automatically,
    /// without also having to manually specify this on the request.
    var additionalHeaders: [String: String] { get }
    /// Encodes the `HTTP` body to binary data.
    /// - Returns: The binary data of `HTTP` body.
    func encodeData() throws -> Data
}

extension HTTPBody {
    public var isEmpty: Bool { return false }
    public var additionalHeaders: [String: String] { return [:] }
}

/// This struct describes `Empty` body of `HTTP` request.
/// See more details of `HTTPBody` protocol.
public struct EmptyBody: HTTPBody {
    // MARK: - instance properties
    public var isEmpty: Bool = true

    // MARK: - methods
    public func encodeData() throws -> Data {
        Data()
    }
}

/// This struct describes binary `HTTP` body.
/// See more details of `HTTPBody` protocol.
public struct DataBody: HTTPBody {
    // MARK: - instance properties

    private let data: Data

    public var additionalHeaders: [String: String]

    public var isEmpty: Bool {
        data.isEmpty
    }

    // MARK: - initialization

    /// Constructs binary `HTTP` body.
    ///
    /// - Parameters:
    ///   - data: The incoming binary data.
    ///   - additionalHeaders: The additional headers that will be used in `HTTP` request.
    /// - Returns: The instance of binary `HTTP` body.
    public init(data: Data, additionalHeaders: [String: String] = [:]) {
        self.data = data
        self.additionalHeaders = additionalHeaders
    }

    // MARK: - methods

    public func encodeData() throws -> Data {
        data
    }
}

/// This struct describes `JSON` `HTTP` body.
/// See more details of `HTTPBody` protocol.
public struct JSONBody<T: Encodable>: HTTPBody {
    // MARK: - instance properties

    private let value: T
    private let encoder = JSONEncoder()

    public var isEmpty: Bool {
        // an empty string encodes to a non-empty JSON value
        false
    }
    public var additionalHeaders: [String: String] = [
        "Content-Type": "application/json; charset=utf-8"
    ]

    // MARK: - initialization

    /// Constructs JSON `HTTP` body.
    ///
    /// - Parameter value: The value that will be encoded to JSON.
    /// - Returns: The instance of JSON `HTTP` body.
    public init(value: T) {
        self.value = value
    }

    // MARK: - methods

    public func encodeData() throws -> Data {
        try encoder.encode(value)
    }
}

/// This struct describes `FORM` `HTTP` body with query items.
/// See more details of `HTTPBody` protocol.
public struct FormBody: HTTPBody {
    // MARK: - instance properties
    private let queryItems: [URLQueryItem]

    public var isEmpty: Bool {
        queryItems.isEmpty
    }

    public var additionalHeaders: [String: String] = [
        "Content-Type": "application/x-www-form-urlencoded; charset=utf-8"
    ]

    // MARK: - initialization

    /// Constructs Form `HTTP` body based on query items.
    ///
    /// - Parameter queryItems: The query items that will be encoded to binary data.
    /// - Returns: The instance of `Form` `HTTP` body.
    public init(queryItems: [URLQueryItem]) {
        self.queryItems = queryItems
    }

    // MARK: - methods

    public func encodeData() throws -> Data {
        let pieces = queryItems.map { (queryItem) -> String in
            let name = urlEncode(queryItem.name)
            let value = urlEncode(queryItem.value ?? "")
            return "\(name)=\(value)"
        }
        let bodyString = pieces.joined(separator: "&")
        return Data(bodyString.utf8)
    }
}

private extension FormBody {
    func urlEncode(_ string: String) -> String {
        let allowedCharacters = CharacterSet.alphanumerics
        return string.addingPercentEncoding(withAllowedCharacters: allowedCharacters) ?? ""
    }
}
