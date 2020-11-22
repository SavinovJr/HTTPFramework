//
//  HTTPMethod.swift
//  HTTPFramework
//
//  Created by Anton Savinov on 25.10.2020.
//

import Foundation

/// This struct provides methods of HTTP protocol.
public struct HTTPMethod: Hashable {
    public static let get = HTTPMethod(rawValue: "GET")
    public static let post = HTTPMethod(rawValue: "POST")
    public static let put = HTTPMethod(rawValue: "PUT")
    public static let delete = HTTPMethod(rawValue: "DELETE")

    /// Represents description of each method as string. For ex. "GET".
    public let rawValue: String
}
