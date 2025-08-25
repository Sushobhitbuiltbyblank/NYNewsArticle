//
//  NYNewsArticle
//
//  Created by Sushobhit Jain on 25/08/25.
//

import XCTest
import SwiftUI
import Combine
@testable import NYNewsArticle

// MARK: - Config Stub
struct StubConfig: ConfigManaging {
    func string(forKey key: String) -> String {
        switch key {
        case ConfigKey.baseURL.rawValue:        return "https://api.nytimes.com/svc/mostpopular/v2"
        case ConfigKey.apiKey.rawValue:         return "TEST"
        default: return ""
        }
    }
    func int(forKey key: String) -> Int {
        return 0
    }
}

// MARK: - Use Case Stub (doesn’t call network)
struct StubUseCase: FetchMostViewedUseCase {
    func execute(section: String, period: Int) async throws -> [Article] {
        return [
            Article(id: 1,
                    url: "https://nytimes.com",
                    adxKeywords: nil,
                    publishedDate: "2025-01-01",
                    section: "Tech",
                    byline: "By Stub",
                    type: "Article",
                    title: "Hello World",
                    abstract: "Abstract",
                    media: [])
        ]
    }
}

@MainActor
final class AppCoordinatorTests: XCTestCase {

    func test_start_returnsAnyView() {
        let sut = AppCoordinator(config: StubConfig(), fetchUseCase: StubUseCase())
        let view = sut.start()
        XCTAssertNotNil(view) // Smoke test
    }

    func test_push_article_updatesPath() {
        let sut = AppCoordinator(config: StubConfig(), fetchUseCase: StubUseCase())
        XCTAssertEqual(sut.path.count, 0)

        let article = Article(id: 42,
                              url: "x",
                              adxKeywords: nil,
                              publishedDate: "",
                              section: "",
                              byline: "",
                              type: "",
                              title: "T",
                              abstract: "A",
                              media: [])
        sut.push(article)
        XCTAssertEqual(sut.path.count, 1)
    }

    func test_start_withExternalPath_binding_isUsable() {
        let sut = AppCoordinator(config: StubConfig(), fetchUseCase: StubUseCase())
        var externalPath = NavigationPath()
        let binding = Binding(
            get: { externalPath },
            set: { externalPath = $0 }
        )

        let view = sut.start(using: binding)
        XCTAssertNotNil(view)

        // external path mutates independently
        XCTAssertEqual(externalPath.count, 0)
        externalPath.append("TestRoute")
        XCTAssertEqual(externalPath.count, 1)
        XCTAssertEqual(sut.path.count, 0)
    }
}

extension JSONDecoder {
    static var nyt: JSONDecoder {
        let d = JSONDecoder()
        d.keyDecodingStrategy = .convertFromSnakeCase
        return d
    }
}
