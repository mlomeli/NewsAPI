//
//  NetworkProvider.swift
//  NewsApi
//
//  Created by Miguel Lomeli on 12/17/24.
//
import Combine

protocol NetworkingService {
    func fetchTopHeadlines() -> AnyPublisher<[Article], NetworkError>
    // TODO: Top Headlines api doesn't have a to parameter. That's exclusive to search.
    func fetchTopHeadlines(to: String) -> AnyPublisher<[Article], NetworkError>
}
