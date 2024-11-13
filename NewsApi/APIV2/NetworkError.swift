//
//  NetworkError.swift
//  NewsApi
//
//  Created by Miguel A Lomeli Cantu on 12/11/24.
//

import Foundation

public enum NetworkError: Error {
    case unknown(data: Data)
    case notFound
    case unauthorized
    case urlError(error: URLError)
    case anyError(reason: Error)
    case apiError(error: ApiError)
    static private let decoder = JSONDecoder()

    static func processResponse(data: Data, response: URLResponse) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknown(data: data)
        }
        if (httpResponse.statusCode == 401) {
            throw NetworkError.unauthorized
        }
        if httpResponse.statusCode == 404 {
            throw NetworkError.notFound
        }
        if 200 ... 299 ~= httpResponse.statusCode {
            return data
        } else {
            do{
                let apiError = try decoder.decode(ApiError.self, from: data)
                throw NetworkError.apiError(error: apiError)
            } catch is DecodingError {
                throw NetworkError.unknown(data: data)
            }
        }
    }
}
