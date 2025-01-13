//
//  ArticleCollectionView.swift
//  NewsApi
//
//  Created by Miguel A Lomeli Cantu on 10/11/24.
//

import SwiftUI
// TO-DO: View Model should be a parameter.
struct ArticleCollectionView<ViewModel>: View where ViewModel: AbstractArticlesViewModel {
    @StateObject var viewModel: ViewModel
    @State var listOfHeights = [Double]()

    var body: some View {
        GeometryReader { reader in
            ScrollView {
                LazyVStack {
                    ForEach(Array(viewModel.articlesData.enumerated()), id: \.offset) { _, article in
                        NavigationLink(destination: ArticleView(article: article)) {
                            ArticleTeaserView(article: article).frame(width: reader.size.width).clipped()
                        }.onAppear(perform: {
                            viewModel.loadMore(article: article)
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
    ArticleCollectionView(viewModel: ArticlesViewModel(apiClient: NewsApiClient()))
}
