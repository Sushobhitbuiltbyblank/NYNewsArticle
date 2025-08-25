//
//  NetworkManager.swift
//  NYNewsArticle
//
//  Created by Sushobhit Jain on 24/08/25.
//
import Foundation

protocol NetworkManaging {
    func send<T: Decodable>(_ request: APIRequest) async throws -> T
}

final class NetworkManager: NetworkManaging {
    private let session: URLSession
    private let decoder: JSONDecoder

    init(session: URLSession = .shared,decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }

    func send<T: Decodable>(_ request: APIRequest) async throws -> T {
        let urlRequest = try request.buildURLRequest()
        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await session.data(for: urlRequest)
        }
        catch { throw NetworkError.transport(error) }
        guard let http = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        guard (200..<300).contains(http.statusCode) else {
            throw NetworkError.http(http.statusCode, data)
        }
        do {
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        }
        catch {
            throw NetworkError.decoding(error)
        }
    }
}

