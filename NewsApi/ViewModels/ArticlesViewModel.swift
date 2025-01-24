//
//  ArticlesViewModel.swift
//  NewsApi
//
//  Created by Miguel A Lomeli Cantu on 11/11/24.
//

import Combine
import Foundation

@MainActor protocol AbstractArticlesViewModel: ObservableObject {
    var articlesData: [Article] { get set }
    var state: ViewModelState { get set }
    func fetchArticles()
    func loadMore(article: Article)
}

enum ViewModelState: Equatable {
    case empty
    case idle
    case loading
    case error(error: NetworkError)

    static func == (lhs: ViewModelState, rhs: ViewModelState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case (.loading, .loading):
            return true
        case let (.error(lhsError), .error(rhsError)):
            return lhsError == rhsError
        default:
            return false
        }
    }
}

class ArticlesViewModel: AbstractArticlesViewModel {
    var apiClient: NetworkingService

    private var articlesCancellable: AnyCancellable?
    private var totalArticles = 0
    private var pageSize = 10
    private var filteredResults = 0
    @Published var articlesData = [Article]()
    @Published var state: ViewModelState = .empty

    init(apiClient: any NetworkingService) {
        self.apiClient = apiClient
    }

    func fetchArticles() {
        if articlesData.count == 0 {
            state = .empty
            articlesCancellable = apiClient.fetchTopHeadlines(request: RequestObject(pageSize: pageSize))
                .receive(on: DispatchQueue.main)
                .sink(
                    receiveCompletion: { status in
                        switch status {
                        case .finished:
                            print("Fetch Articles Finished")
                        case .failure(let error):
                            self.state = .error(error: error)
                            print(error)
                        }
                    },
                    receiveValue: { responseObject in
                        self.totalArticles = responseObject.totalResults
                        self.articlesData = responseObject.articles.filter { element in
                            if element.urlImage == nil {
                                self.filteredResults += 1
                                return false
                            }
                            return true
                        }
                        self.state = .idle
                    })
        }
    }

    func loadMore(article: Article) {
        let totalPages = (totalArticles + pageSize - 1) / pageSize  // Int divisions round to floor
        let currentPage = articlesData.isEmpty ? 1 : (articlesData.count + filteredResults - 1) / pageSize + 1

        guard let latestArticle = articlesData.last,
            article.id == latestArticle.id,
            currentPage < totalPages
        else {
            return
        }
        self.state = .loading
        articlesCancellable = apiClient.fetchTopHeadlines(
            request: RequestObject(pageSize: pageSize, page: currentPage + 1)
        )
        .receive(on: DispatchQueue.main)
        .sink(
            receiveCompletion: { status in
                switch status {
                case .finished:
                    print("Fetch Articles Finished")
                case .failure(let error):
                    self.state = .error(error: error)
                    print(error)
                }
            },
            receiveValue: { responseObject in
                let filteredArticles = responseObject.articles.filter { element in
                    if element.urlImage == nil {
                        self.filteredResults += 1
                        return false
                    }
                    return true
                }
                self.state = .idle
                self.articlesData.append(contentsOf: filteredArticles)
            })
    }
}
