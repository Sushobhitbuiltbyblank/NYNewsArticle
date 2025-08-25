//
//  AppCoordinatorView.swift
//  NYNewsArticle
//
//  Created by Sushobhit Jain on 25/08/25.
//

import Foundation
import SwiftUI

struct AppCoordinatorView: View {
    @StateObject private var coordinator: AppCoordinator

    init(config: ConfigManaging = ConfigManager.shared,
                network: NetworkManaging = NetworkManager()) {
        // Default DI for production
        let repository = DefaultArticlesRepository(network: network, config: config)
        let useCase    = DefaultFetchMostViewedUseCase(repository: repository)
        _coordinator = StateObject(wrappedValue: AppCoordinator(config: config, fetch: useCase))
    }

    /// Testable initializer (inject fakes)
    init(coordinator: AppCoordinator) {
        _coordinator = StateObject(wrappedValue: coordinator)
    }

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.list()
                .navigationDestination(for: Route.self) { route in
                    coordinator.destination(for: route)
                }
        }
        .environmentObject(coordinator) // so children can push/pop if needed
    }
}

