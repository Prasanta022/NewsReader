//
//  MockNewsAPIManager.swift
//  NewsReader
//
//  Created by Prasanta Sahu on 08/12/24.
//

import XCTest
@testable import NewsReader

class MockNewsAPIManager: XCTestCase, APIClient {
    
    func fetchNewsArticleList(days: Int, completion: @escaping (Result<ArticleResponse, APINetworkError>) -> Void) {
        let bundle = Bundle(for: MockNewsAPIManager.self)
        let jsonFileURL = bundle.url(forResource: "news", withExtension: "json")
        
        guard  let url = jsonFileURL,
            let newsArticleData = try? Data(contentsOf: url)
            else { return }
        
        do {
            let result = try JSONDecoder().decode(ArticleResponse.self, from: newsArticleData)
            completion(.success(result))
        } catch {
            completion(.failure(.genericError))
        }
    }
}
