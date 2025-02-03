//
//  ContentView.swift
//  NewsApi
//
//  Created by Miguel A Lomeli Cantu on 04/11/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.newsApiClient) private var newsApiClient: NetworkingService
    var body: some View {
        TabView {
            NavigationStack {
                ArticleCollectionView(viewModel: ArticlesViewModel(apiClient: newsApiClient, type: .topHeadlines(country: "us")))
            }.tabItem {
                Label("Top Headlines", systemImage: "newspaper")
            }

            NavigationStack {
                FilterArticleCollectionView(viewModel: ArticlesViewModel(apiClient: newsApiClient, type: .everything(q: "")))
            }.tabItem {
                Label("Everything", systemImage: "globe")
            }

        }

    }

}

#Preview {
    ContentView()
}
