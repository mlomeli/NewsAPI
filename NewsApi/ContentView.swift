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
                ArticleCollectionView(viewModel: ArticlesViewModel(apiClient: newsApiClient, type: .topHeadlines))
            }.tabItem {
                Label("Top Headlines", systemImage: "newspaper")
            }

            NavigationStack {
                ArticleCollectionView(
                    viewModel: ArticlesViewModel(apiClient: newsApiClient, type: .everything(search: "apple"))
                )
            }.tabItem {
                Label("Everything", systemImage: "globe")
            }

        }

    }

}

#Preview {
    ContentView()
}
