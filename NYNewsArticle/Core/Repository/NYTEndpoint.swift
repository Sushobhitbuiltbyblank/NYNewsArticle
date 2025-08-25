//
//  Untitled.swift
//  NYNewsArticle
//
//  Created by Sushobhit Jain on 24/08/25.
//
import Foundation

struct NYTEndpoint: APIEndpoint {
    enum Kind {
        case mostViewed(section: String, period: Int)
    }
    let kind: Kind
    init(_ kind: Kind) { self.kind = kind }

    var path: String {
        switch kind {
        case .mostViewed(let section, let period):
            return "/mostviewed/\(section)/\(period).json"
        }
    }
    var method: HTTPMethod { .GET }

    var queryItems: [URLQueryItem] {
        switch kind {
        case .mostViewed:
            return []
        }
    }
    //all-sections
    //7
}
