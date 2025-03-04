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
    @Published var state: ViewModelState = .idle
    @Published var type: ViewModelType

    init(apiClient: any NetworkingService, type: ViewModelType) {
        self.type = type
        self.apiClient = apiClient
        if case .topHeadlines = type {
            self.state = ViewModelState.empty
        }
    }
    // MARK: Protocol Implementation
    func fetchArticles() {
            state = .empty
            articlesCancellable = getPublisher()
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

        articlesCancellable = getPublisher(page: currentPage + 1)
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
    private func getPublisher(page: Int = 1) -> AnyPublisher<ResponseObject, NetworkError> {
        switch type {
        case .topHeadlines(let country):
            let request = RequestObject(queryType: .topHeadlines(country: country), pageSize: pageSize, page: page)
            return apiClient.fetchTopHeadlines(request: request)
        case .everything(let q):
            let request = RequestObject(queryType: .everything(q: q), pageSize: pageSize, page: page)
            return apiClient.fetchEverything(request: request)
        }
    }

}
