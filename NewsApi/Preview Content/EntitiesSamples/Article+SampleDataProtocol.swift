//
//  Untitled.swift
//  NewsApi
//
//  Created by Miguel A Lomeli Cantu on 09/11/24.
//
import Foundation
extension Article: SampleDataProtocol {
    static func sampleSelf() -> Article {
        return Article(source: nil, author: nil,
                       title: "It's Always Sunny in Philadelphia",
                       description: """
                        The series follows the exploits of a group
                        of narcissistic and sociopathic friends who run the
                        Irish dive bar Paddy's Pub in South Philadelphiaß
                        """,
                       url: URL(string: "https://google.com"),
                       urlToImage: URL.localURLForXCAssetJPG(name: "Pexels1"),
                       publishedAt: Date())
    }
}
