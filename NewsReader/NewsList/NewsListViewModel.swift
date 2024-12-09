//
//  NewsListViewModel.swift
//  NewsReader
//
//  Created by Prasanta Sahu on 08/12/24.
//

import Foundation
import SwiftData

class NewsListViewModel: ObservableObject {
    
    @Published var articles: [Article] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    @Published var storedArticles: [Article] = []

    lazy var apiClient: APIClient = NewsAPIManager()
    
    func fetchArticles() async throws {
        DispatchQueue.main.async { [weak self] in
            self?.isLoading = true
        }
        apiClient.fetchNewsArticleList(days: 7, completion: { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles.results ?? []
            case .failure(let error):
                print(error)
                DispatchQueue.main.async { [weak self] in
                    self?.errorMessage = error.description
                }
            }
            DispatchQueue.main.async { [weak self] in
                self?.isLoading = false
            }
        })
    }
}
