//
//  NYNewsArticle
//
//  Created by Sushobhit Jain on 25/08/25.
//


import XCTest
@testable import NYNewsArticle

final class ArticleDetailViewModelTests: XCTestCase {
    @MainActor func testViewModelHoldsArticle() {
        let article = Article(id: 1, url: "https://nytimes.com", adxKeywords: nil,
                              publishedDate: "2025-08-24", section: "World", byline: "By A",
                              type: "Article", title: "T", abstract: "A", media: [])
        let vm = ArticleDetailViewModel(article: article)
        XCTAssertEqual(vm.article.title, "T")
        XCTAssertEqual(vm.article.byline, "By A")
    }
}

