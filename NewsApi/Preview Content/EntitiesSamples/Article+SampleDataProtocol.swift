//
//  Untitled.swift
//  NewsApi
//
//  Created by Miguel A Lomeli Cantu on 09/11/24.
//
import Foundation
extension Article: SampleDataProtocol {
    static func sampleSelf() -> Article {
        return Article(source: Source(id: nil, name: "FX"), author: nil,
                       title: "It's Always Sunny in Philadelphia",
                       description: """
                        The series follows the exploits of a group of narcissistic and sociopathic friends who run the Irish dive bar Paddy's Pub in South Philadelphiaß
                        """,
                       url: URL(string: "https://google.com")!,
                       urlToImage: URL.localURLForXCAssetJPG(name: "Pexels1"),
                       publishedAt: "date")
    }

    static func sampleSet() ->[Article] {
        var articles: [Article] = []
        for idx in 1...10 {
            let article = Article(source: Source(id: nil, name: "FX"), author: nil,
                           title: "It's Always Sunny in Philadelphia",
                           description: """
                            The series follows the exploits of a group of narcissistic and sociopathic friends who run the Irish dive bar Paddy's Pub in South Philadelphiaß
                            """,
                           url: URL(string: "https://google.com?\(idx)")!,
                           urlToImage: URL(string: "https://picsum.photos/200/300")!,
                           publishedAt: "date")
            articles.append(article)
        }
        return articles
    }
}
