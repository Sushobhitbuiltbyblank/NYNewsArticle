//
//  ArticlesListView.swift
//  NYNewsArticle
//
//  Created by Sushobhit Jain on 25/08/25.
//

import SwiftUI

struct ArticlesListView: View {
    @EnvironmentObject private var coordinator: AppCoordinator // optional if you passed onSelect
    @StateObject var viewModel: ArticlesListViewModel
    init(
        viewModel: ArticlesListViewModel,
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        content
            .nytNavBar("NY Times Most Popular")
            .onAppear { if case .idle = viewModel.state { viewModel.load() } }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            ProgressView().frame(maxWidth: .infinity, maxHeight: .infinity)
        case .failed(let message):
            VStack(spacing: 12) {
                Image(systemName: "exclamationmark.triangle.fill")
                Text(message).multilineTextAlignment(.center)
                Button("Retry") { viewModel.load() }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .loaded(let items):
            List(items, id: \.id) { article in
                Button {
                    coordinator.push(.detail(article))
                } label: {
                    ArticleRowView(article: article)
                }
                .buttonStyle(.plain)
            }
            .listStyle(.plain)
        }
    }
}
