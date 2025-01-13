//
//  ArticlesViewModel.swift
//  NewsApi
//
//  Created by Miguel A Lomeli Cantu on 11/11/24.
//

import Foundation
import Combine

@MainActor protocol AbstractArticlesViewModel: ObservableObject {
    var articlesData: [Article] {get set}
    func fetchArticles()
    func loadMore(article: Article)
}

class ArticlesViewModel: AbstractArticlesViewModel {

    init(apiClient: any NetworkingService) {
        self.apiClient = apiClient
    }

    private var articlesCancellable: AnyCancellable?
    var apiClient: NetworkingService
    @Published var articlesData = [Article]()

    func fetchArticles() {
        if articlesData.count == 0 {
            articlesCancellable = apiClient.fetchTopHeadlines()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { status in
                switch status {
                case .finished:
                    print("Fetch Articles Finished")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }, receiveValue: { articles in
                self.articlesData = articles.filter { $0.urlToImage != nil }
            })
        }
    }

    func loadMore(article: Article) {
        guard let latestArticle = articlesData.last,
              article.id == latestArticle.id else {
            return
        }
        articlesCancellable = apiClient.fetchTopHeadlines(to: latestArticle.publishedAt)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { status in
                switch status {
                case .finished:
                    print("Fetch Articles Finished")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }, receiveValue: { articles in
                let filterArticles = articles.filter { $0.urlToImage != nil }
                self.articlesData.append(contentsOf: filterArticles)
            })
    }
}
