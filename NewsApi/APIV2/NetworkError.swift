//
//  NetworkError.swift
//  NewsApi
//
//  Created by Miguel A Lomeli Cantu on 12/11/24.
//

import Foundation

public enum NetworkError: Error, Equatable, CustomStringConvertible {
    case unknown(data: Data)  // Could not process http response
    case notFound  // 404 Status Code
    case unauthorized  // 401 Status code
    case urlError(error: URLError)
    case anyError(reason: Error)  // Generic Error
    case apiError(error: ApiError)  // Error Response from Endpoint
    static private let decoder = JSONDecoder()

    static func processResponse(data: Data, response: URLResponse) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknown(data: data)
        }
        if httpResponse.statusCode == 401 {
            throw NetworkError.unauthorized
        }
        if httpResponse.statusCode == 404 {
            throw NetworkError.notFound
        }
        if 200...299 ~= httpResponse.statusCode {
            return data
        } else {
            do {
                let apiError = try decoder.decode(ApiError.self, from: data)
                throw NetworkError.apiError(error: apiError)
            } catch is DecodingError {
                throw NetworkError.unknown(data: data)
            }
        }
    }
    // MARK: - CustomStringConvertible
    public var description: String {
        switch self {
        case .unknown(data: let data):
            let dataString = String(data: data, encoding: .utf8) ?? "Couldn't parse error data as utf8"
            return "Unknown Error: \(dataString)"
        case .notFound:
            return "HTTP Error: 404 Not Found"
        case .unauthorized:
            return "HTTP Error: 401 Unauthorized"
        case .urlError(error: let error):
            return "URL Error: \(error)"
        case .anyError(reason: let reason):
            return "Error: \(reason)"
        case .apiError(error: let error):
            return "API Error: \(error.code) -  \(error.status) - \(error.message)"
        }
    }

    // MARK: - Equatable
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.unknown(let lhsData), .unknown(let rhsData)):
            return lhsData == rhsData
        case (.notFound, .notFound):
            return true
        case (.unauthorized, .unauthorized):
            return true
        case (.urlError(let lhsError), .urlError(let rhsError)):
            return lhsError == rhsError
        case (.anyError(let lhsError), .anyError(let rhsError)):
            return type(of: lhsError) == type(of: rhsError) && String(describing: lhsError) == String(describing: rhsError)
        case (.apiError(let lhsError), .apiError(let rhsError)):
            return String(describing: lhsError) == String(describing: rhsError)
        default:
            return false
        }
    }
}
