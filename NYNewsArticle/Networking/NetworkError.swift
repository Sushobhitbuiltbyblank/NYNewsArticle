//
//  NetworkError.swift
//  NYNewsArticle
//
//  Created by Sushobhit Jain on 24/08/25.
//

import Foundation

enum NetworkError: LocalizedError, Equatable {
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        return true
    }

    case badURL
    case transport(Error)
    case invalidResponse
    case http(Int, Data?)
    case decoding(Error)

    var errorDescription: String? {
        switch self {
        case .badURL: return "The URL is invalid."
        case .transport(let e): return e.localizedDescription
        case .invalidResponse: return "Invalid server response."
        case .http(let code, _): return "Server returned status code \(code)."
        case .decoding: return "Failed to decode the response."
        }
    }
}
