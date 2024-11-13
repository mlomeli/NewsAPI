//
//  ResponseObject.swift
//  NewsApiV2
//
//  Created by Miguel A Lomeli Cantu on 04/11/24.
//

struct ResponseObject: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}
