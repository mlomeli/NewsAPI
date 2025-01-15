//
//  ApiService.swift
//  NewsApi
//
//  Created by Miguel A Lomeli Cantu on 11/11/24.
//

import Combine
import Foundation

class NewsApiClient: NetworkingService {

    private var session: URLSession
    private let decoder: JSONDecoder

    init() {
        decoder = JSONDecoder()
        session = URLSession.shared
    }

    // MARK: - Top Headlines
    func fetchTopHeadlines() -> AnyPublisher<[Article], NetworkError> {
        let responseObjectPublisher: AnyPublisher<ResponseObject, NetworkError> =
            getRequest(endpoint: .topHeadlines, params: ["country": "us"])
            .eraseToAnyPublisher()

        return
            responseObjectPublisher
            .map { response in
                return response.articles
            }.eraseToAnyPublisher()
    }
    func fetchTopHeadlines(to: String) -> AnyPublisher<[Article], NetworkError> {
        let responseObjectPublisher: AnyPublisher<ResponseObject, NetworkError> =
            getRequest(endpoint: .topHeadlines, params: ["to": to, "country": "us"])
            .eraseToAnyPublisher()

        return
            responseObjectPublisher
            .map { response in
                return response.articles
            }.eraseToAnyPublisher()
    }

    // MARK: - HTTP Requests
    func getRequest<T: Decodable>(endpoint: Endpoint, params: [String: String]? = nil)
        -> AnyPublisher<T, NetworkError>
    {
        var url = Self.makeURL(endpoint: endpoint)
        var request: URLRequest
        var queryItems = [URLQueryItem]()
        if let params = params {
            for (query, value) in params {
                queryItems.append(URLQueryItem(name: query, value: value))
            }
            url = url.appending(queryItems: queryItems)
        }
        request = URLRequest(url: url)
        return session.dataTaskPublisher(for: request)
            .tryMap { data, response in
                print(T.self)
                return try NetworkError.processResponse(data: data, response: response)
            }.decode(type: T.self, decoder: decoder)
            .mapError { error in
                print(error.localizedDescription)
                if let urlError = error as? URLError {
                    return NetworkError.urlError(error: urlError)
                }
                return error as? NetworkError ?? NetworkError.anyError(reason: error)
            }
            .eraseToAnyPublisher()
    }
    static private func makeURL(endpoint: Endpoint) -> URL {
        var url: URL
        url = URL(string: "\(EnvData.URLPREFIX)\(EnvData.HOST)?apiKey=\(EnvData.apiKey)")!
        url = url.appendingPathComponent(endpoint.path())
        let component = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        return component.url!
    }
}
