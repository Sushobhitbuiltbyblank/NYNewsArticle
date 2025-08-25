//
//  ArticlesListViewModel.swift
//  NYNewsArticle
//
//  Created by Sushobhit Jain on 25/08/25.
//

import Foundation
import Combine

final class ArticlesListViewModel: ObservableObject {
    enum State: Equatable {
        case idle, loading, loaded([Article]), failed(String)
    }
    @Published private(set) var state: State = .idle
    let section = "all-sections"
    let period = 7
    private let fetchUseCase: FetchMostViewedUseCase

    init(fetchUseCase: FetchMostViewedUseCase) {
        self.fetchUseCase = fetchUseCase
    }

    func load() {
        Task {
            state = .loading
            do {
                let items = try await fetchUseCase.execute(section: section, period: period)
                state = .loaded(items)
            } catch {
                state = .failed((error as? LocalizedError)?.errorDescription ?? "Unknown error")
            }
        }
    }
}
