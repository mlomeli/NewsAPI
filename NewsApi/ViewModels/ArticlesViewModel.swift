//
//  ArticlesViewModel.swift
//  NewsApi
//
//  Created by Miguel A Lomeli Cantu on 11/11/24.
//

import Foundation
import Combine

@MainActor class ArticlesViewModel: ObservableObject {

    private var articlesCancellable: AnyCancellable?

    @Published var articlesData = [Article]()

    func fetchArticles() {
        if (articlesData.count == 0){
            articlesCancellable = Article.fetchTopHeadlines()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { status in
                switch status {
                case .finished:
                    print("Fetch Articles Finished")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }, receiveValue: { articles in
                self.articlesData = articles
            })
        }
    }
    func loadMore(article: Article) {
        guard let latestArticle = articlesData.last,
              article.id == latestArticle.id else {
            return
        }
        articlesCancellable = Article.fetchTopHeadlines(to: latestArticle.publishedAt)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { status in
                switch status {
                case .finished:
                    print("Fetch Articles Finished")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }, receiveValue: { articles in
                for newArticle in articles {

                }
                self.articlesData.append(contentsOf: articles)
            })
    }
}
