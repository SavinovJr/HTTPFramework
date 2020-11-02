//
//  HTTPBody.swift
//  HTTPFramework
//
//  Created by Антон Савинов on 02.11.2020.
//

import Foundation

public protocol HTTPBody {
    var isEmpty: Bool { get }
    // when we encode a value as JSON
    // we’d like a way to specify the Content-Type: application/json header automatically,
    // without also having to manually specify this on the request.
    var additionalHeaders: [String: String] { get }
    
    func encodeData() throws -> Data
}

extension HTTPBody {
    public var isEmpty: Bool { return false }
    public var additionalHeaders: [String: String] { return [:] }
}

public struct EmptyBody: HTTPBody {
    public var isEmpty: Bool = true
    
    public func encodeData() throws -> Data {
        Data()
    }
}

public struct DataBody: HTTPBody {
    
    private let data: Data
    
    public var additionalHeaders: [String : String]
    
    public var isEmpty: Bool {
        data.isEmpty
    }
    
    init(data: Data, additionalHeaders: [String: String] = [:]) {
        self.data = data
        self.additionalHeaders = additionalHeaders
    }
    
    public func encodeData() throws -> Data {
        data
    }
}

public struct JSONBody<T: Encodable>: HTTPBody {
    
    private let value: T
    private let encoder = JSONEncoder()
    
    public var isEmpty: Bool {
        // an empty string encodes to a non-empty JSON value
        false
    }
    public var additionalHeaders: [String : String] = [
        "Content-Type": "application/json; charset=utf-8"
    ]
    
    init(value: T) {
        self.value = value
    }
    
    public func encodeData() throws -> Data {
        try encoder.encode(value)
    }
}

public struct FormBody: HTTPBody {
    private let queryItems: [URLQueryItem]
    
    public var isEmpty: Bool {
        queryItems.isEmpty
    }
    
    public var additionalHeaders: [String : String] = [
        "Content-Type": "application/x-www-form-urlencoded; charset=utf-8"
    ]
    
    init(queryItems: [URLQueryItem]) {
        self.queryItems = queryItems
    }
    
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
