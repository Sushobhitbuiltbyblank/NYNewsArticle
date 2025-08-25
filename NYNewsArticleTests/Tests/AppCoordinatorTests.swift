//
//  NYNewsArticle
//
//  Created by Sushobhit Jain on 25/08/25.
//

import XCTest
import SwiftUI
import Combine
@testable import NYNewsArticle

// MARK: - Stubs
struct StubConfig: ConfigManaging {
    func string(forKey key: String) -> String {
        switch key {
        case "section": return "all-sections"
        case ConfigKey.baseURL.rawValue: return "https://api.nytimes.com/svc/mostpopular/v2"
        case ConfigKey.apiKey.rawValue: return "TEST"
        default: return ""
        }
    }
    func int(forKey key: String) -> Int {
        key == "period" ? 7 : 0
    }
}

struct StubUseCase: FetchMostViewedUseCase {
    func execute(section: String, period: Int) async throws -> [Article] {
        [Article(id: 1, url: "https://nytimes.com", adxKeywords: nil,
                 publishedDate: "2025-01-01", section: "Tech", byline: "By Stub",
                 type: "Article", title: "Hello", abstract: "World", media: [])]
    }
}

// MARK: - Tests

@MainActor
final class AppCoordinatorTests: XCTestCase {

    func test_coordinatorView_buildsNavigationStack() {
        let coordinator = AppCoordinator(config: StubConfig(), fetch: StubUseCase())
        let view = AppCoordinatorView(coordinator: coordinator)

        // Smoke test: hosting the view should not crash and should produce a VC
        let host = UIHostingController(rootView: view)
        XCTAssertNotNil(host.view, "AppCoordinatorView should produce a view hierarchy")
    }

    func test_push_route_updatesPath() {
        let sut = AppCoordinator(config: StubConfig(), fetch: StubUseCase())
        XCTAssertEqual(sut.path.count, 0)

        let article = Article(id: 42, url: "x", adxKeywords: nil,
                              publishedDate: "", section: "", byline: "",
                              type: "", title: "T", abstract: "A", media: [])

        sut.push(.detail(article))
        XCTAssertEqual(sut.path.count, 1, "push(.detail) should append to NavigationPath")
    }

    func test_pop_and_popToRoot() {
        let sut = AppCoordinator(config: StubConfig(), fetch: StubUseCase())

        // push two routes
        sut.push(.detail(Article(id: 1, url: "", adxKeywords: nil,
                                 publishedDate: "", section: "", byline: "",
                                 type: "", title: "", abstract: "", media: [])))
        sut.push(.detail(Article(id: 2, url: "", adxKeywords: nil,
                                 publishedDate: "", section: "", byline: "",
                                 type: "", title: "", abstract: "", media: [])))
        XCTAssertEqual(sut.path.count, 2)

        // pop one
        sut.pop()
        XCTAssertEqual(sut.path.count, 1, "pop() should remove the last element")

        // pop to root
        sut.popToRoot()
        XCTAssertEqual(sut.path.count, 0, "popToRoot() should clear the path")
    }
}

extension JSONDecoder {
    static var nyt: JSONDecoder {
        let d = JSONDecoder()
        d.keyDecodingStrategy = .convertFromSnakeCase
        return d
    }
}
