//
//  NetworkProvider.swift
//  NewsApi
//
//  Created by Miguel Lomeli on 12/17/24.
//
import Combine

protocol NetworkingService {
    func fetchTopHeadlines() -> AnyPublisher<[Article], NetworkError>
    func fetchTopHeadlines(to: String) -> AnyPublisher<[Article], NetworkError>
}
