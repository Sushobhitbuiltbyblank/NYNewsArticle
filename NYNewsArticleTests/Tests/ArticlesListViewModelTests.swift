//
//  NYNewsArticle
//
//  Created by Sushobhit Jain on 25/08/25.
//

import XCTest
@testable import NYNewsArticle

final class ArticlesListViewModelTests: XCTestCase {
    struct StubUseCase: FetchMostViewedUseCase {
        let articles: [Article]
        func execute(section: String, period: Int) async throws -> [Article] { articles }
    }

    func testLoadSetsLoadedState() async {
        let a = Article(id: 1, url: "", adxKeywords: nil, publishedDate: "", section: "", byline: "", type: "", title: "Hello", abstract: "", media: [])
        let vm = await ArticlesListViewModel(fetchUseCase: StubUseCase(articles: [a]))
        await vm.load()
        if case let .loaded(items) = await vm.state {
            XCTAssertEqual(items.count, 1)
        } else {
            XCTFail("Expected loaded state")
        }
    }
}
