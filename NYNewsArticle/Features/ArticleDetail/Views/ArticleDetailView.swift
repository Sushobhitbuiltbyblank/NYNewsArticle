//
//  ArticleDetailView.swift
//  NYNewsArticle
//
//  Created by Sushobhit Jain on 25/08/25.
//

import SwiftUI

struct ArticleDetailView: View {
    @ObservedObject var viewModel: ArticleDetailViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                if let url = viewModel.article.media.first?.mediaMetadata.last?.url,
                   let imgURL = URL(string: url) {
                    imageView(imageUrl: imgURL)
                }
                
                Text(viewModel.article.title)
                    .font(.title3).bold()
                Text(viewModel.article.byline)
                    .font(.footnote).foregroundColor(.secondary)
                Text(viewModel.article.abstract)
                    .font(.body)
                linView(urlstring: viewModel.article.url)
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func imageView(imageUrl: URL) -> some View {
        AsyncImage(url: imageUrl) { image in
            image.resizable().scaledToFill()
        } placeholder: {
            Rectangle().fill(Color.gray.opacity(0.2))
        }
        .frame(height: 200)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    private func linView(urlstring: String) -> some View {
        Link("Open in Browser", destination: URL(string: urlstring) ?? URL(string: "https://nytimes.com")!)
            .padding(.top, 8)
    }
}

#Preview {
    ArticleDetailView(viewModel: ArticleDetailViewModel(article: Article(id: 1, url: "", adxKeywords: "", publishedDate: "2025-08-21", section: "Style", byline: "By Someone", type: "Article", title: "Sample Title", abstract: "Abstract", media: [])))
}
