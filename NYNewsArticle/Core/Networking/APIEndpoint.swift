//
//  APIEndpoint.swift
//  NYNewsArticle
//
//  Created by Sushobhit Jain on 24/08/25.
//

import Foundation

protocol APIEndpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var queryItems: [URLQueryItem] { get }
    var body: [String: Any]? { get }
}

extension APIEndpoint {
    var headers: [String: String] { [:] }
    var queryItems: [URLQueryItem] { [] }
    var body: [String: Any]? { nil }
}
