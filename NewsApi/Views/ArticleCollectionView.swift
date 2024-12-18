//
//  ArticleCollectionView.swift
//  NewsApi
//
//  Created by Miguel A Lomeli Cantu on 10/11/24.
//

import SwiftUI
//TO-DO: View Model should be a parameter.
struct ArticleCollectionView: View {
    @StateObject var viewModel: ArticlesViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue: ArticlesViewModel(apiClient: NewsApiClient()))
    }
    
    var body: some View {
        GeometryReader { reader in
            ScrollView {
                LazyVStack {
                    ForEach(Array(viewModel.articlesData.enumerated()), id: \.offset) { _, article in
                        NavigationLink(destination: ArticleView(article: article)) {
                            ArticleTeaserView(article: article).frame(height: reader.size.width*3/4 + 75).clipped()
                        }.onAppear(perform: {
                            viewModel.loadMore(article:article)
                        })

                    }
                }
            }
        }.onAppear(perform: {
            viewModel.fetchArticles()
        })
    }
}

#Preview {
    ArticleCollectionView()
}
