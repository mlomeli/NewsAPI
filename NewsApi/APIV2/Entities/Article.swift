//
//  News.swift
//  NewsApiV2
//
//  Created by Miguel A Lomeli Cantu on 04/11/24.
//
import Foundation

struct Article: Identifiable, Decodable {
    let source: Source?
    let author: String?
    let title: String
    let description: String?
    let url: URL
    let urlToImage: URL?
    let publishedAt: String
    var id: String {
        url.absoluteString
    }
}
