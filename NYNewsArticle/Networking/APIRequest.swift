//
//  APIRequest.swift
//  NYNewsArticle
//
//  Created by Sushobhit Jain on 24/08/25.
//

import Foundation

struct APIRequest {
    public var baseURL: URL
    public var path: String
    public var method: HTTPMethod
    public var headers: [String: String]
    public var query: [URLQueryItem]
    public var body: [String: Any]?
    public var timeout: TimeInterval

    public init(
        baseURL: URL,
        path: String,
        method: HTTPMethod,
        headers: [String: String] = [:],
        query: [URLQueryItem] = [],
        body: [String: Any]? = nil,
        timeout: TimeInterval = 30
    ) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.headers = headers
        self.query = query
        self.body = body
        self.timeout = timeout
    }

    func buildURLRequest() throws -> URLRequest {
        guard var comps = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else {
            throw NetworkError.badURL
        }
        comps.path += path
        if !query.isEmpty { comps.queryItems = (comps.queryItems ?? []) + query }
        guard let url = comps.url else { throw NetworkError.badURL }

        var req = URLRequest(url: url, timeoutInterval: timeout)
        req.httpMethod = method.rawValue
        headers.forEach { req.setValue($1, forHTTPHeaderField: $0) }

        if let body = body {
            // Convert [String: Any] to JSON
            do {
                let data = try JSONSerialization.data(withJSONObject: body, options: [])
                req.httpBody = data
                if req.value(forHTTPHeaderField: "Content-Type") == nil {
                    req.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
                }
            } catch {
                throw NetworkError.decoding(error) // reuse decoding error for "cannot serialize"
            }
        }
        return req
    }
}
