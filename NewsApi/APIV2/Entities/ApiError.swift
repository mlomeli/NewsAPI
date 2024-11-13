//
//  Error.swift
//  NewsApi
//
//  Created by Miguel A Lomeli Cantu on 13/11/24.
//

public struct ApiError: Decodable {
    let message: String
    let code: String
    let status: String
}
