//
//  NetworkError.swift
//  NewsApi
//
//  Created by Miguel A Lomeli Cantu on 12/11/24.
//

import Foundation

public enum NetworkError: Error {
    case unknown(data: Data),
    case notFound,
    case unauthorized
    static func processResponse(data: Data, response: URLResponse) throws -> NetworkError {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknown(data: data)
        }
        if httpResponse.statusCode == 404 {
            throw NetworkError.notFound
        }

    }
}
