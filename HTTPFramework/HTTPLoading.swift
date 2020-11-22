//
//  HTTPLoading.swift
//  HTTPFramework
//
//  Created by Антон Савинов on 02.11.2020.
//

import Combine

/// Describes `HTTP` loading protocol.
public protocol HTTPLoading {
    /// Describers `HTTP` load command.
    ///
    /// - Parameter request: The `HTTP` request to be performed.
    /// - Returns: The instance of `AnyPublisher` object that will contain the future result of `HTTP` request
    /// as `HTTPResponse` and `HTTPError`
    func load(request: HTTPRequest) -> AnyPublisher<HTTPResponse, HTTPError>
}

extension URLSession: HTTPLoading {
    public func load(request: HTTPRequest) -> AnyPublisher<HTTPResponse, HTTPError> {
        guard let url = request.url else {
            fatalError("Can't fetch url from HTTPRequest")
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue

        for (header, value) in request.headers {
            urlRequest.addValue(value, forHTTPHeaderField: header)
        }

        if request.body.isEmpty == false {
            for (header, value) in request.body.additionalHeaders {
                urlRequest.addValue(value, forHTTPHeaderField: header)
            }
            do {
                urlRequest.httpBody = try request.body.encodeData()
            } catch {
                fatalError("Can't encode data from request body")
            }
        }
        let publisher = dataTaskPublisher(for: urlRequest)
        return publisher.map { (data, urlResponse) -> HTTPResponse in
            if let httpUrlResponse = urlResponse as? HTTPURLResponse {
                return HTTPResponse(response: httpUrlResponse, request: request, body: data)
            } else {
                return HTTPResponse(response: HTTPURLResponse(), request: request, body: data)
            }
        }.mapError { (failure) -> HTTPError in
            let code: HTTPError.Code
            switch failure.code {
            case .cancelled:
                code = .canceled
            case .badURL:
                code = .badUrl
            default:
                code = .unkown
            }
            return HTTPError(code: code, request: request, response: nil, underlyingError: failure)
        }.eraseToAnyPublisher()
    }
}
