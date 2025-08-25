//
//  NYNewsArticle
//
//  Created by Sushobhit Jain on 25/08/25.
//

import Foundation
@testable import NYNewsArticle

final class URLProtocolStub: URLProtocol {
    static var response: HTTPURLResponse?
    static var data: Data?
    static var error: Error?

    override class func canInit(with request: URLRequest) -> Bool { true }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }

    override func startLoading() {
        if let error = URLProtocolStub.error {
            client?.urlProtocol(self, didFailWithError: error)
            return
        }
        if let response = URLProtocolStub.response {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        if let data = URLProtocolStub.data {
            client?.urlProtocol(self, didLoad: data)
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    override func stopLoading() { }
}


final class StubNetwork: NetworkManaging {
    var responseData: Data?
    var error: Error?

    func send<T: Decodable>(_ request: APIRequest) async throws -> T {
        if let error = error {
            throw error
        }
        guard let data = responseData else {
            throw NetworkError.invalidResponse
        }
        let decoder = JSONDecoder.nyt
        return try decoder.decode(T.self, from: data)
    }
}
