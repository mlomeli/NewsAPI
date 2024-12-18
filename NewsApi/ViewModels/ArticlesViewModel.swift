//
//  ArticlesViewModel.swift
//  NewsApi
//
//  Created by Miguel A Lomeli Cantu on 11/11/24.
//

import Foundation
import Combine

@MainActor class ArticlesViewModel: ObservableObject {
    
    init(apiClient: any NetworkingService = NewsApiClient()) {
        self.apiClient = apiClient
    }
    

    private var articlesCancellable: AnyCancellable?
    var apiClient: NetworkingService
    @Published var articlesData = [Article]()
    //TO-DO: Move Api calls to Protocol.
    func fetchArticles() {
        if (articlesData.count == 0){
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
                self.articlesData = articles
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
                for newArticle in articles {

                }
                self.articlesData.append(contentsOf: articles)
            })
    }
}
