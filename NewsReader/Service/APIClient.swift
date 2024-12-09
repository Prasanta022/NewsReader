//
//  APIClient.swift
//  NewsReader
//
//  Created by Prasanta Sahu on 08/12/24.
//

import Foundation


enum APINetworkError: Error {
    case noInternetError
    case domainError
    case decodingError
    case badUrl
    case tokenError
    case genericError

    var description: String {
        switch self {
        case .noInternetError:
            return "No network available. Please check your network connection."
        case .decodingError:
            return "Decoding error occurred."
        default:
            return "Something went wrong. Please try after sometime."
        }
    }
}

protocol APIClient {

    func fetchNewsArticleList(days: Int, completion: @escaping (Result<ArticleResponse, APINetworkError>) -> Void)
}
