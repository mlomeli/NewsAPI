//
//  NetworkProvider.swift
//  NewsApi
//
//  Created by Miguel Lomeli on 12/17/24.
//
import Combine

protocol NetworkingService {
    func fetchTopHeadlines(request: RequestObject) -> AnyPublisher<ResponseObject, NetworkError>
    // TODO: Top Headlines api doesn't have a to parameter. That's exclusive to search.
    func fetchTopHeadlines() -> AnyPublisher<ResponseObject, NetworkError>
    func fetchEverything(request: RequestObject) -> AnyPublisher<ResponseObject, NetworkError>
}
