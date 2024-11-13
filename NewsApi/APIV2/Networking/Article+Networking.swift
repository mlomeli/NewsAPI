//
//  Article+Networking.swift
//  NewsApi
//
//  Created by Miguel A Lomeli Cantu on 13/11/24.
//

import Combine
import Foundation

extension Article {
    static func fetchTopHeadlines() -> AnyPublisher<[Article], NetworkError> {
        let responseObjectPublisher: AnyPublisher<ResponseObject, NetworkError> =
        ApiService.shared.getRequest(endpoint: .topHeadlines, params: ["country": "us"])
            .eraseToAnyPublisher()

        return
            responseObjectPublisher
            .map { response in
                return response.articles
            }.eraseToAnyPublisher()
    }

    static func fetchTopHeadlines(to: String) -> AnyPublisher<[Article], NetworkError> {
        let responseObjectPublisher: AnyPublisher<ResponseObject, NetworkError> =
        ApiService.shared.getRequest(endpoint: .topHeadlines, params: ["to": to, "country": "us"])
            .eraseToAnyPublisher()

        return
            responseObjectPublisher
            .map { response in
                return response.articles
            }.eraseToAnyPublisher()
    }
}
