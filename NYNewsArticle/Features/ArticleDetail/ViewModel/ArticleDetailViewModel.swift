//
//  ArticleDetailViewModel.swift
//  NYNewsArticle
//
//  Created by Sushobhit Jain on 25/08/25.
//

import Foundation
import Combine

@MainActor
final class ArticleDetailViewModel: ObservableObject {
    @Published var article: Article
    init(article: Article) {
        self.article = article
    }
}
