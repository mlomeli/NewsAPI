//
//  MockNetworkingService.swift
//  NewsApi
//
//  Created by Miguel Lomeli on 1/15/25.
//

// MARK: - Top Headlines
//
import Combine
import Foundation

class MockNetworkingService: NetworkingService {
    func fetchTopHeadlines(request: RequestObject) -> AnyPublisher<ResponseObject, NetworkError> {
        return genericPublisher()

    }
    func fetchTopHeadlines() -> AnyPublisher<ResponseObject, NetworkError>{
        return genericPublisher()
    }
    func fetchEverything(request: RequestObject) -> AnyPublisher<ResponseObject, NetworkError> {
        return genericPublisher()
    }
    private func genericPublisher() -> AnyPublisher<ResponseObject, NetworkError> {
        return Bundle.main.url(forResource: "sample", withExtension: "json")
            .publisher
            .tryMap { json in
                guard let data = try? Data(contentsOf: json) else {
                    throw NetworkError.notFound
                }
                return data
            }
            .decode(type: ResponseObject.self, decoder: JSONDecoder())
            .mapError { error in
                if let urlError = error as? URLError {
                    return NetworkError.urlError(error: urlError)
                }
                return error as? NetworkError ?? NetworkError.anyError(reason: error)
            }
            .eraseToAnyPublisher()
    }
}
