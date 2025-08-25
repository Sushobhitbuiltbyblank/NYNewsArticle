//
//  RootCoordinator.swift
//  NYNewsArticle
//
//  Created by Sushobhit Jain on 25/08/25.
//

import SwiftUI
import Combine

@MainActor
protocol RootCoordinator: ObservableObject {
    var path: NavigationPath { get set }

    func start(using externalPath: Binding<NavigationPath>?) -> AnyView

    func buildContent(using path: Binding<NavigationPath>) -> AnyView

    // Navigation helpers
    func push<V: Hashable>(_ value: V)
    func pop()
    func popToRoot()
}

extension RootCoordinator {
    // Default start() when caller doesn't pass a path
    func start(using externalPath: Binding<NavigationPath>? = nil) -> AnyView {
        let navBinding = externalPath ?? Binding(
            get: { self.path },
            set: { self.path = $0 }
        )

        return AnyView(
            NavigationStack(path: navBinding) {
                buildContent(using: navBinding)
            }
        )
    }

    // Default no-op content (subtypes override)
    func buildContent(using path: Binding<NavigationPath>) -> AnyView {
        AnyView(EmptyView())
    }

    // Default nav helpers
    func push<V: Hashable>(_ value: V) { path.append(value) }
    func pop() { path.removeLast() }
    func popToRoot() { path = NavigationPath() }
}


