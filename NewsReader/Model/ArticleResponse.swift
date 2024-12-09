//
//  ArticleResponse.swift
//  NewsReader
//
//  Created by Prasanta Sahu on 08/12/24.
//

import Foundation

// MARK: - ArticleResponse
class ArticleResponse: Codable {
    var status, copyright: String?
    var numResults: Int?
    var results: [Article]?

    enum CodingKeys: String, CodingKey {
        case status, copyright
        case numResults = "num_results"
        case results
    }

    init(status: String?, copyright: String?, numResults: Int?, results: [Article]?) {
        self.status = status
        self.copyright = copyright
        self.numResults = numResults
        self.results = results
    }
}
