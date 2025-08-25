//
//  AppCoordinator.swift
//  NYNewsArticle
//
//  Created by Sushobhit Jain on 25/08/25.
//

import SwiftUI
import Combine

@MainActor
final class AppCoordinator: ObservableObject {
    @Published var path = NavigationPath()

    // DI
    private let config: ConfigManaging
    private let fetch: FetchMostViewedUseCase

    init(config: ConfigManaging, fetch: FetchMostViewedUseCase) {
        self.config = config
        self.fetch = fetch
    }

    // Navigation API
    func push(_ route: Route) {
        path.append(route)
    }
    
    func pop(){
        guard !path.isEmpty else { return }; path.removeLast()
    }
    
    func popToRoot(){
        path = NavigationPath()
    }

    // Factory helpers (optional, keeps body tidy)
    @ViewBuilder
    func list() -> some View {
        ArticlesListView(
            viewModel: ArticlesListViewModel(
                fetchUseCase: fetch))
    }

    @ViewBuilder
    func destination(for route: Route) -> some View {
        switch route {
        case .detail(let article):
            ArticleDetailView(viewModel: ArticleDetailViewModel(article: article))
        }
    }
}

