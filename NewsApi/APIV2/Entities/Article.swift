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
    private let url: String?
    private var urlToImage: String?
    let publishedAt: String
    var id: String {
        (url ?? "") + title + publishedAt
    }

    init(
        source: Source?,
        author: String?,
        title: String,
        description: String?,
        url: String?,
        urlToImage: String?,
        publishedAt: String
    ) {
        self.source = source
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
    }
    
    var articleURL: URL? {
        guard let urlString = url,
              !urlString.isEmpty else {
            return nil
        }
        return URL(string:urlString)
    }
    var urlImage: URL? {
        guard let urlString = urlToImage,
              !urlString.isEmpty else {
            return nil
        }
        return URL(string:urlString)
    }


}

