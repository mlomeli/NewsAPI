//
//  AbstractArticlesViewModel.swift
//  NewsApi
//
//  Created by Miguel Lomeli on 1/30/25.
//
import Combine

@MainActor protocol AbstractArticlesViewModel: ObservableObject {
    var articlesData: [Article] { get set }
    var state: ViewModelState { get set }
    var type: ViewModelType {get set }
    func fetchArticles()
    func loadMore(article: Article)
}

enum  ViewModelType {
    case topHeadlines(country: String)
    case everything(q: String)
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
        case (.empty, .empty):
            return true
        default:
            return false
        }
    }
}
