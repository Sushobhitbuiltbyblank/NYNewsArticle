//
//  AppCoordinatorViewTests.swift
//  NYNewsArticleTests
//
//  Created by Sushobhit Jain on 25/08/25.
//

import XCTest
import SwiftUI
@testable import NYNewsArticle

@MainActor
final class AppCoordinatorViewTests: XCTestCase {
    // Simple stubs
    struct StubConfig: ConfigManaging {
        func string(forKey key: String) -> String {
            switch key {
            default: return ""
            }
        }
        func int(forKey key: String) -> Int { 7 }
    }
    
    struct StubUseCase: FetchMostViewedUseCase {
        func execute(section: String, period: Int) async throws -> [Article] {
            [Article(id: 1, url: "", adxKeywords: nil, publishedDate: "", section: "",
                     byline: "", type: "", title: "T", abstract: "", media: [])]
        }
    }
    
    func test_push_pop_popToRoot() {
        let sut = AppCoordinator(config: StubConfig(), fetch: StubUseCase())
        XCTAssertEqual(sut.path.count, 0)
        
        sut.push(.detail(Article(id: 1, url: "", adxKeywords: nil, publishedDate: "", section: "", byline: "", type: "", title: "", abstract: "", media: [])))
        XCTAssertEqual(sut.path.count, 1)
        
        sut.pop()
        XCTAssertEqual(sut.path.count, 0)
        
        sut.push(.detail(Article(id: 1, url: "", adxKeywords: nil, publishedDate: "", section: "", byline: "", type: "", title: "", abstract: "", media: [])))
        sut.push(.detail(Article(id: 2, url: "", adxKeywords: nil, publishedDate: "", section: "", byline: "", type: "", title: "", abstract: "", media: [])))
        XCTAssertEqual(sut.path.count, 2)
        
        sut.popToRoot()
        XCTAssertEqual(sut.path.count, 0)
    }
    
    func test_coordinatorView_buildsNavigationStack() {
        let coordinator = AppCoordinator(config: StubConfig(), fetch: StubUseCase())
        let view = AppCoordinatorView(coordinator: coordinator)
        // Smoke test: just ensure it builds a view
        _ = UIHostingController(rootView: view)
    }
}

