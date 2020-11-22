//
//  HTTPResult.swift
//  HTTPFramework
//
//  Created by Anton Savinov on 25.10.2020.
//

import Foundation

typealias HTTPResult = Result<HTTPResponse, HTTPError>

extension HTTPResult {

    var request: HTTPRequest {
        switch self {
        case .success(let response):
                return response.request
        case .failure(let error):
                return error.request
        }
    }

    var response: HTTPResponse? {
        switch self {
        case .success(let response):
            return response
        case .failure(let error):
            return error.response
        }
    }
}
