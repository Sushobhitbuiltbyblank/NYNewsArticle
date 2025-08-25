//
//  FetchMostViewedUseCase.swift
//  NYNewsArticle
//
//  Created by Sushobhit Jain on 25/08/25.
//

import Foundation

protocol FetchMostViewedUseCase {
    func execute(section: String, period: Int) async throws -> [Article]
}

final class DefaultFetchMostViewedUseCase: FetchMostViewedUseCase {
    private let repository: ArticlesRepository
    
    init(repository: ArticlesRepository) {
        self.repository = repository
    }
    
    func execute(section: String, period: Int) async throws -> [Article] {
        try await repository.mostViewed(section: section, period: period)
    }
}
