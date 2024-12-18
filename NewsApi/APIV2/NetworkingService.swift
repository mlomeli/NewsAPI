//
//  NetworkProvider.swift
//  NewsApi
//
//  Created by Miguel Lomeli on 12/17/24.
//
import Combine
protocol NetworkingService {
    func getRequest<T: Decodable>(endpoint: Endpoint, params: [String: String]?)
    -> AnyPublisher<T, NetworkError>
    func fetchTopHeadlines() -> AnyPublisher<[Article], NetworkError>
    func fetchTopHeadlines(to: String) -> AnyPublisher<[Article], NetworkError>
}


