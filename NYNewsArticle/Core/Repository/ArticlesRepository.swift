//
//  Untitled.swift
//  NYNewsArticle
//
//  Created by Sushobhit Jain on 25/08/25.
//

import Foundation

protocol ArticlesRepository {
    func mostViewed(section: String, period: Int) async throws -> [Article]
}

final class DefaultArticlesRepository: ArticlesRepository {
    private let network: NetworkManaging
    private let config: ConfigManaging

    init(network: NetworkManaging, config: ConfigManaging) {
        self.network = network
        self.config = config
    }

    func mostViewed(section: String, period: Int) async throws -> [Article] {
        guard let base = URL(string: config.string(forKey: ConfigKey.baseURL.rawValue)) else {
            throw NetworkError.badURL
        }

        // 1) Keep endpoint usage unchanged
        let endpoint = NYTEndpoint(.mostViewed(section: section, period: period))

        // 2) Expand to a generic request with injected API key as query
        let request = endpoint.makeRequest(
            baseURL: base,
            extraQuery: [URLQueryItem(name: "api-key", value: config.string(forKey: ConfigKey.apiKey.rawValue))]
        )

        // 3) Send generically and decode
        let response: MostPopularResponse = try await network.send(request)
        return response.results
    }
}
