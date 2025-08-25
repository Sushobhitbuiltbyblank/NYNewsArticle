//
//  NYNewsArticle
//
//  Created by Sushobhit Jain on 25/08/25.
//

import XCTest
@testable import NYNewsArticle

@MainActor
final class NetworkManagerTests: XCTestCase {
    func test_send_decodesValidJSON() async throws {
        // given: a dummy URL & APIRequest
        let json = #"{ "status": "OK","copyright": "Copyright (c) 2025 The New York Times Company.  All Rights Reserved.","num_results":20,"results":[{"id":1,"url":"https://nytimes.com","published_date":"2025-01-01","section":"Tech","byline":"By Test","type":"Article","title":"Hello","abstract":"World","media":[]}]} "#
        let data = json.data(using: .utf8)!

        // Use a custom URLProtocol to stub URLSession (or simpler: StubNetwork)
        let stub = StubNetwork()
        stub.responseData = data

        // when
        let request = APIRequest(baseURL: URL(string: "https://dummy.com")!,
                                 path: "/test.json",
                                 method: .GET)
        let response: MostPopularResponse = try await stub.send(request)

        // then
        XCTAssertEqual(response.results.first?.title, "Hello")
    }

    func test_send_throwsOnTransportError() async {
        let stub = StubNetwork()
        stub.error = URLError(.notConnectedToInternet)

        let request = APIRequest(baseURL: URL(string: "https://dummy.com")!,
                                 path: "/test.json",
                                 method: .GET)

        do {
            let _: MostPopularResponse = try await stub.send(request)
            XCTFail("Expected to throw")
        } catch {
            XCTAssertTrue(error is URLError)
        }
    }
}
