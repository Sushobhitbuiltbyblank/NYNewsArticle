//
//  APIEndpoint+Request.swift
//  NYNewsArticle
//
//  Created by Sushobhit Jain on 24/08/25.
//

import Foundation

extension APIEndpoint {
    func makeRequest(baseURL: URL,
                     extraHeaders: [String: String] = [:],
                     extraQuery: [URLQueryItem] = []) -> APIRequest {
        APIRequest(
            baseURL: baseURL,
            path: path,
            method: method,
            headers: headers.merging(extraHeaders, uniquingKeysWith: { _, new in new }),
            query: (queryItems + extraQuery),
            body: body
        )
    }
}
