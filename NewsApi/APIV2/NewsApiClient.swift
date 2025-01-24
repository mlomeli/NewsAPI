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
        decoder.dataDecodingStrategy
        session = URLSession.shared
    }

    // MARK: - NetworkingService Protocol
    func fetchTopHeadlines(request: RequestObject) -> AnyPublisher<ResponseObject, NetworkError> {
        let responseObjectPublisher: AnyPublisher<ResponseObject, NetworkError> =
            getRequest(endpoint: .topHeadlines, params: request.toArray())
            .eraseToAnyPublisher()

        return responseObjectPublisher
    }

    func fetchTopHeadlines() -> AnyPublisher<ResponseObject, NetworkError> {
        return fetchTopHeadlines(request: RequestObject())
    }

    // MARK: - HTTP Requests
    func getRequest<T: Decodable>(endpoint: Endpoint, params: [String: String]? = nil)
        -> AnyPublisher<T, NetworkError>
    {
        var url = Self.makeURL(endpoint: endpoint, params: params)
        let request = URLRequest(url: url)
        return session.dataTaskPublisher(for: request)
            .tryMap { data, response in
                return try NetworkError.processResponse(data: data, response: response)
            }.decode(type: T.self, decoder: decoder)
            .mapError { error in
                if let urlError = error as? URLError {
                    return NetworkError.urlError(error: urlError)
                }
                return error as? NetworkError ?? NetworkError.anyError(reason: error)
            }
            .eraseToAnyPublisher()
    }
    static private func makeURL(endpoint: Endpoint, params: [String:String]?) -> URL {
        var url: URL
        url = URL(string: "\(EnvData.URLPREFIX)\(EnvData.HOST)?apiKey=\(EnvData.apiKey)")!
        url = url.appendingPathComponent(endpoint.path())

        var queryItems = [URLQueryItem]()
        if let params = params {
            for (query, value) in params {
                queryItems.append(URLQueryItem(name: query, value: value))
            }
            url = url.appending(queryItems: queryItems)
        }
        let component = URLComponents(url: url, resolvingAgainstBaseURL: false)!

        return component.url!
    }
}
