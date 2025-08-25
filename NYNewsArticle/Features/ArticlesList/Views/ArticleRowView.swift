//
//  ArticleRowView.swift
//  NYNewsArticle
//
//  Created by Sushobhit Jain on 25/08/25.
//

import SwiftUI

struct ArticleRowView: View {
    let article: Article

    var body: some View {
        HStack(spacing: 12) {
            titleImageView(imageUrl: article.thumbnailURL)

            VStack(alignment: .leading, spacing: 4) {
                Text(article.title)
                    .font(.subheadline).fontWeight(.semibold)
                    .lineLimit(2)
                HStack(alignment: .bottom) {
                    Text(article.byline)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                    publishedDateView(dateText: article.publishedDate)
                }
            }
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }
    
    private func titleImageView(imageUrl: URL?) -> some View {
        AsyncImage(url: imageUrl) { img in
            img.resizable().scaledToFill()
        } placeholder: {
            Circle().fill(Color.gray.opacity(0.3))
        }
        .frame(width: 44, height: 44)
        .clipShape(Circle())
    }
    
    private func publishedDateView(dateText: String) -> some View {
        HStack(spacing: 5) {
            Image(systemName: "calendar")
                .font(.caption)
                .foregroundColor(.gray)
            Text(dateText)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    ArticleRowView(
        article: Article(id: 1, url: "", adxKeywords: "", publishedDate: "2025-08-21", section: "Style", byline: "By Someone", type: "Article", title: "Sample Title", abstract: "Abstract", media: [])
    )
        .padding()
}
