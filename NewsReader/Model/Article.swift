//
//  Article.swift
//  NewsReader
//
//  Created by Prasanta Sahu on 08/12/24.
//

import Foundation
import SwiftData

@Model
final class Article: Codable {

    @Attribute(.unique) var id: Int
    var assetId: Int
    var author: String?
    var title: String?
    var publisherDate: String?
    var source: String?
    var url: String?
    var media: [Media]?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case assetId = "asset_id"
        case author = "byline"
        case title = "title"
        case publisherDate = "published_date"
        case source = "source"
        case url = "url"
        case media = "media"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.assetId = try container.decode(Int.self, forKey: .assetId)
        self.author = try container.decode(String.self, forKey: .author)
        self.title = try container.decode(String.self, forKey: .title)
        self.publisherDate = try container.decode(String.self, forKey: .publisherDate)
        self.source = try container.decode(String.self, forKey: .source)
        self.url = try container.decode(String.self, forKey: .url)
        self.media = try container.decode([Media].self, forKey: .media)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(assetId, forKey: .assetId)
        try container.encode(author, forKey: .author)
        try container.encode(title, forKey: .title)
        try container.encode(publisherDate, forKey: .publisherDate)
        try container.encode(source, forKey: .source)
        try container.encode(url, forKey: .url)
        try container.encode(media, forKey: .media)

    }
}

// MARK: - Media
class Media: Codable {
    var type, subtype, caption, copyright: String?
    var approvedForSyndication: Int?
    var mediaMetadata: [MediaMetadatum]?

    enum CodingKeys: String, CodingKey {
        case type, subtype, caption, copyright
        case approvedForSyndication = "approved_for_syndication"
        case mediaMetadata = "media-metadata"
    }

    init(type: String?, subtype: String?, caption: String?, copyright: String?, approvedForSyndication: Int?, mediaMetadata: [MediaMetadatum]?) {
        self.type = type
        self.subtype = subtype
        self.caption = caption
        self.copyright = copyright
        self.approvedForSyndication = approvedForSyndication
        self.mediaMetadata = mediaMetadata
    }
}

// MARK: - MediaMetadatum
class MediaMetadatum: Codable {
    var url: String?
    var format: String?
    var height, width: Int?

    init(url: String?, format: String?, height: Int?, width: Int?) {
        self.url = url
        self.format = format
        self.height = height
        self.width = width
    }
}
