//
//  NewsApiTests.swift
//  NewsApiTests
//
//  Created by Miguel A Lomeli Cantu on 04/11/24.
//

import Testing
@testable import NewsApi

struct ViewModelTests {
    @Test func testDefaultValues() async throws {
        let eModel = await ArticlesViewModel(apiClient: MockNetworkingService(), type: .everything(q: ""))
        await #expect(eModel.articlesData.isEmpty)
        await #expect(eModel.state == .idle)
        //Top Headlines starts empty and no articles until offline support is added.
        let thModel = await ArticlesViewModel(apiClient: MockNetworkingService(), type: .topHeadlines(country: "us"))
        await #expect(thModel.articlesData.isEmpty)
        await #expect( thModel.state == .empty)
    }

    @Test func testFetchArticles() async throws {
        #expect(true)
    }
}
