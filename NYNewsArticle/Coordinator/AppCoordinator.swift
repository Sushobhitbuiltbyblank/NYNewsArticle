//
//  AppCoordinator.swift
//  NYNewsArticle
//
//  Created by Sushobhit Jain on 25/08/25.
//

import SwiftUI
import Combine

@MainActor
final class AppCoordinator: RootCoordinator {
    @Published var path = NavigationPath()

    // DI
    private let config: ConfigManaging
    private let fetchUseCase: FetchMostViewedUseCase

    // Designated init
    init(config: ConfigManaging, fetchUseCase: FetchMostViewedUseCase) {
        self.config = config
        self.fetchUseCase = fetchUseCase
    }

    // Convenience init
    convenience init() {
        let configuration = ConfigManager.shared
        let network: NetworkManaging = NetworkManager()
        let repository = DefaultArticlesRepository(
            network: network,
            config: configuration
        )
        let mostViewedUserCase  = DefaultFetchMostViewedUseCase(repository: repository)
        self.init(config: configuration, fetchUseCase: mostViewedUserCase)
    }

    // Provide the feature content as AnyView
    func buildContent(using path: Binding<NavigationPath>) -> AnyView {
        let view = ArticlesListView(
            viewModel: ArticlesListViewModel(
                fetchUseCase: fetchUseCase
            )
        ) { article in
            path.wrappedValue.append(article)
        }
        .navigationDestination(for: Article.self) { article in
            ArticleDetailView(viewModel: ArticleDetailViewModel(article: article))
        }

        return AnyView(view)
    }
}
