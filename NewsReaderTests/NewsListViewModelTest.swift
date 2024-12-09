//
//  NewsListViewModelTest.swift
//  NewsReader
//
//  Created by Prasanta Sahu on 08/12/24.
//

import XCTest
@testable import NewsReader

class NewsListViewModelTest: XCTestCase {

    var articles: [Article]?
    let service: APIClient = MockNewsAPIManager()
    let newsListViewModel = NewsListViewModel(apiClient: NewsAPIManager())

    override func setUp() {
        service.fetchNewsArticleList(days: 7) { [weak self] result in
            switch result {
            case .success(let articleResponse):
                self?.articles = articleResponse.results
            case .failure:
                self?.articles = nil
            }

            self?.newsListViewModel.articles = self?.articles ?? []
        }
    }
    
    func test_empty_news_articles() {
        XCTAssertTrue(!newsListViewModel.articles.isEmpty, "Article should not be empty")
    }

    func test_valid_article_id() {
        XCTAssertNotNil(newsListViewModel.articles.first?.id, "Article id should not be nil")
    }
    
    func test_valid_article_title() {
        XCTAssertNotNil(newsListViewModel.articles.first?.title, "Article title should not be nil")
    }
    
    func test_valid_article_author() {
        XCTAssertNotNil(newsListViewModel.articles.first?.author, "Article author should not be nil")
    }
    
    func test_valid_article_publisher_date() {
        XCTAssertNotNil(newsListViewModel.articles.first?.publisherDate, "Article publisher date should not be nil")
    }
    
    func test_vaid_article_model() {
        let firstArticle = articles?.first
        XCTAssertTrue(newsListViewModel.articles.first?.title == firstArticle?.title
                      && newsListViewModel.articles.first?.author == firstArticle?.author
                      && newsListViewModel.articles.first?.publisherDate == firstArticle?.publisherDate, "Article model should be same")
    }
    
    func test_fetch_articles() async throws {
        // call asynchronous method to fetch articles
        try await newsListViewModel.fetchArticles()
        
        // wait for article to get
        let articles = try XCTUnwrap(newsListViewModel.articles, "Articles should be fetched")
        
        // Assert for articles count
        XCTAssertTrue(articles.count > 0, "Article should not be empty")
    }
}
