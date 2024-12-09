//
//  NewsAPIManager.swift
//  NewsReader
//
//  Created by Prasanta Sahu on 08/12/24.
//

import Foundation

class NewsAPIManager: APIClient {

    private struct Constants {
        
        static let apiKey: String = "api-key=WcBgtbkpdrPK3ESSPqCA9qfGcwrqRG5g"
        static let apiBaseUrl: String = "https://api.nytimes.com/svc/mostpopular/v2/viewed/"
    }

    private var urlSession = URLSession.shared

    func fetchNewsArticleList(days: Int, completion: @escaping (Result<ArticleResponse, APINetworkError>) -> Void) {
        let apiUrl = "\(Constants.apiBaseUrl)\(days).json?\(Constants.apiKey)"
        guard let url =  URL(string: apiUrl) else {
            completion(.failure(.badUrl))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "GET"
        let dataTask = urlSession.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            if let newsArticleData = data {
                print(String(data: newsArticleData, encoding: .utf8) ?? "")

                do {
                    let result = try JSONDecoder().decode(ArticleResponse.self, from: newsArticleData)
                    DispatchQueue.main.async {
                        completion(.success(result))
                    }
                } catch {
                    completion(.failure(.decodingError))
                }
            } else {
                completion(.failure(.genericError))
            }
        })
        dataTask.resume()
    }
}
