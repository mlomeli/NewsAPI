import Combine
//
//  StubArticleViewModel.swift
//  NewsApi
//
//  Created by Miguel Lomeli on 1/15/25.
//
import Foundation

class StubArticleViewModel: AbstractArticlesViewModel {
    @Published var articlesData = [Article]()
    @Published var state: ViewModelState = .empty
    @Published var type: ViewModelType = .topHeadlines
    private var totalArticles = 0
    private var pageSize = 0
    private var articlesCancellable: AnyCancellable?

    func fetchArticles() {
        if articlesData.count == 0 {
            state = .loading
            articlesCancellable = Just(Article.sampleSet())
                .delay(for: .seconds(1), scheduler: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        print("Completed without error")
                    case .failure(let error):
                        self.state = .error(error: NetworkError.anyError(reason: error))
                    }
                } receiveValue: { value in
                    self.articlesData = value
                    self.totalArticles = 17
                    self.state = .idle
                }
        }
    }

    func loadMore(article: Article) {
        guard let latestArticle = articlesData.last,
            article.id == latestArticle.id,
            articlesData.count <= totalArticles
        else {
            return
        }
        state = .loading
        articlesCancellable = Just(Article.sampleSet())
            .delay(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Load more finished")
                case .failure(let error):
                    print("Error: \(error)")
                    self.state = .error(error: NetworkError.anyError(reason: error))
                }
            } receiveValue: { value in
                self.articlesData.append(contentsOf: value)
                self.state = .idle
            }
    }
}
