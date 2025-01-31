//
//  ArticlesViewModel.swift
//  NewsApi
//
//  Created by Miguel A Lomeli Cantu on 11/11/24.
//

import Combine
import Foundation

class ArticlesViewModel: AbstractArticlesViewModel {
    var apiClient: NetworkingService

    private var articlesCancellable: AnyCancellable?
    private var totalArticles = 0
    private var pageSize = 10
    private var filteredResults = 0
    @Published var articlesData = [Article]()
    @Published var state: ViewModelState = .empty
    @Published var type: ViewModelType

    init(apiClient: any NetworkingService, type: ViewModelType) {
        self.type = type
        self.apiClient = apiClient
    }
    // MARK: Protocol Implementation
    func fetchArticles() {
        if articlesData.count == 0 {
            state = .empty

            var request = RequestObject(pageSize: pageSize)
            if case .everything(let term) = type {
                request.q = term
                request.countryCode = nil
            }
            articlesCancellable = getPublisher(request: request)
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
        var request = RequestObject(pageSize: pageSize, page: currentPage + 1)

        if case .everything(let term) = type {
            request.q = term
            request.countryCode = nil
        }

        articlesCancellable = getPublisher(request: request)
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

    // MARK: Helper functions
    private func getPublisher(request: RequestObject) -> AnyPublisher<ResponseObject, NetworkError> {
        switch type {
        case .topHeadlines:
            return apiClient.fetchTopHeadlines(request: request)
        case .everything:
            return apiClient.fetchEverything(request: request)
        }
    }

}
