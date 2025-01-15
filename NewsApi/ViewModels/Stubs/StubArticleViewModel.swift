//
//  StubArticleViewModel.swift
//  NewsApi
//
//  Created by Miguel Lomeli on 1/15/25.
//
import Foundation
import Combine

class StubArticleViewModel: AbstractArticlesViewModel {
    @Published var articlesData = [Article]()
    private var articlesCancellable: AnyCancellable?

    func fetchArticles() {
        if articlesData.count == 0 {
            articlesCancellable = Just(Article.sampleSet())
                .delay(for: .seconds(1), scheduler: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        print("Completed without error")
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                } receiveValue: { value in
                    self.articlesData = value
                }
        }
    }

    func loadMore(article: Article) {
        guard let latestArticle = articlesData.last,
              article.id == latestArticle.id else {
            return
        }
        articlesCancellable = Just(Article.sampleSet())
            .delay(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Completed without error")
                case .failure(let error):
                    print("Error: \(error)")
                }
            } receiveValue: { value in
                self.articlesData = value
            }
    }
}
