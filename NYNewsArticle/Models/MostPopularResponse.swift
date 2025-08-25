//
//  MostPopularResponse.swift
//  NYNewsArticle
//
//  Created by Sushobhit Jain on 25/08/25.
//

import Foundation

struct MostPopularResponse: Decodable, Equatable {
    let status, copyright: String
    let numResults: Int
    let results: [Article]
    
    enum CodingKeys: String, CodingKey {
        case status, copyright
        case numResults
        case results
    }
}

struct Article: Decodable, Equatable, Identifiable, Hashable {
    let id: Int
    let url: String
    let adxKeywords: String?
    let publishedDate: String
    let section: String
    let byline: String
    let type: String
    let title: String
    let abstract: String
    let media: [Media]
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }

    var thumbnailURL: URL? {
        return URL(string: media.last?.mediaMetadata.last?.url ?? "")
    }
    
    
}

struct Media: Decodable, Equatable {
    let type: String
    let subtype: String?
    let caption: String?
    let mediaMetadata: [MediaMeta]

    enum CodingKeys: String, CodingKey {
        case type, subtype, caption
        case mediaMetadata = "media-metadata"
    }
}

struct MediaMeta: Decodable, Equatable, Hashable {
    let url: String
    let format: String
    let height: Int
    let width: Int
}
