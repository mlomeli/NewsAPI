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

    var title: String {
        switch viewModel.type {
        case .topHeadlines:
            return "Top Headlines"
        case .everything(let search):
            return "Search: \(search)"
        }
    }

    var body: some View {
        let presentingError = Binding<Bool>(
            get: {
                if case .error = viewModel.state {
                    return true
                }
                return false
            },
            set: { _ in viewModel.state = .idle}
        )
        Group {
            switch viewModel.state {
            case .empty:
                ProgressView().onAppear(perform: {
                    viewModel.fetchArticles()
                })
            default:
                collectionView()
            }
        }.navigationTitle(title).alert("Error", isPresented: presentingError) {
            Button("OK", role: .cancel) {
                viewModel.state = .idle
            }
        } message: {
            if case .error(let error) = viewModel.state {
                Text(error.localizedDescription)
            }
        }
    }

    func collectionView() -> some View {
        return GeometryReader { reader in
            ScrollView {
                LazyVStack {
                    ForEach(Array(viewModel.articlesData.enumerated()), id: \.offset) { _, article in
                        NavigationLink(destination: ArticleView(article: article)) {
                            ArticleTeaserView(article: article)
                                .frame(width: reader.size.width)
                                .frame(minHeight: reader.size.width*3/4 + 100)
                                .clipped()
                        }.onAppear(perform: {
                            viewModel.loadMore(article: article)
                        })
                    }
                }
            }
        }
    }
}

#Preview {
    ArticleCollectionView(viewModel: StubArticleViewModel())
}
