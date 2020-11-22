//
//  HTTPStatus.swift
//  HTTPFramework
//
//  Created by Anton Savinov on 25.10.2020.
//

import Foundation

/// This struct describes status in response message of HTTP protocol
public struct HTTPStatus: Hashable {
    /// Represents integer value of HTTP status in response message
    public let rawValue: Int
}
