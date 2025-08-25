//
//  ConfigManager.swift
//  NYNewsArticle
//
//  Created by Sushobhit Jain on 24/08/25.
//

import Foundation

protocol ConfigManaging {
    func string(forKey key: String) -> String
    func int(forKey key: String) -> Int
}

enum ConfigKey: String {
    case baseURL = "API_BASE_URL"
    case apiKey  = "API_KEY"
}

final class ConfigManager: ConfigManaging {
    
    static let shared = ConfigManager()
    private let dict: [String: Any]

    init(bundle: Bundle = .main) {
        guard let url = bundle.url(forResource: "Configuration", withExtension: "plist"),
              let data = try? Data(contentsOf: url),
              let dict = (try? PropertyListSerialization.propertyList(from: data, options: [], format: nil)) as? [String: Any] else {
            self.dict = [:]
            return
        }
        self.dict = dict
    }

    func string(forKey key: String) -> String {
        dict[key] as? String ?? ""
    }
    func int(forKey key: String) -> Int {
        dict[key] as? Int ?? 0
    }
}
