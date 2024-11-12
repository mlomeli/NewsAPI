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
        
    }
}
