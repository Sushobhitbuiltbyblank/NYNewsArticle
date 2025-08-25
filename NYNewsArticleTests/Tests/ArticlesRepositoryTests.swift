//
//  NYNewsArticle
//
//  Created by Sushobhit Jain on 25/08/25.
//

import XCTest
@testable import NYNewsArticle

final class ArticlesRepositoryTests: XCTestCase {
    final class FakeConfig: ConfigManaging {
        func string(forKey key: String) -> String {
            switch key {
            case ConfigKey.baseURL.rawValue: return "https://api.nytimes.com/svc/mostpopular/v2"
            case ConfigKey.apiKey.rawValue: return "TEST"
            default: return ""
            }
        }
        func int(forKey key: String) -> Int { 0 }
    }
    struct FakeClient: NetworkManaging {
        func send<T>(_ request: NYNewsArticle.APIRequest) async throws -> T where T : Decodable {
            try JSONDecoder.nyt.decode(T.self, from: data)
        }

        let data: Data
    }

    func testFetchMostViewed() async throws {
        
        let jsonURL = Bundle(for: type(of: self)).url(forResource: "test_mostpopular", withExtension: "json")!
        let data = try Data(contentsOf: jsonURL)
        let repo = await DefaultArticlesRepository(
            network: FakeClient(data: data),
            config: FakeConfig()
        )
        let items = try await repo.mostViewed(section: "all-sections", period: 7)
        XCTAssertGreaterThan(items.count, 0)
    }
}
