//
//  ApiService.swift
//  NewsApi
//
//  Created by Miguel A Lomeli Cantu on 11/11/24.
//

import Foundation
import Combine
class ApiService {
    private let baseURL = URL(string: "")!

//    public func getRequest<T: Decodable>(endpoint: Endpoint, params: [String: String]? = nil) -> AnyPublisher<T ,Error> {
//        var url = Self.makeURL(endpoint: endpoint)
//        var request: URLRequest
////        if let params = params {
////            for (query, value) in params {
////                url = url.appending(query, value: value)
////            }
////            request = URLRequest(url: url)
////        } else {
////            request = URLRequest(url: url)
////        }
//
//    }
//    static private func makeURL(endpoint: Endpoint) -> URL {
//        var url: URL
//        url = URL(string: "\(EnvData.URLPREFIX)\(EnvData.HOST)")!
//        url = url.appendingPathComponent(endpoint.path())
//        let component = URLComponents(url: url, resolvingAgainstBaseURL: false)!
//        return component.url!
//    }
}
