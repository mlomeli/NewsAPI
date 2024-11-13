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
        let articlesUrlStrings = "https://newsapi.org/v2/top-headlines?country=us&apiKey="
        print(articlesUrlStrings)
        if let url = URL(string: articlesUrlStrings) {
            print(url)
            articlesCancellable =  URLSession.shared.dataTaskPublisher(for: url)
                .receive(on: DispatchQueue.main)
                .tryMap { (data, response) -> Data in
                    print(response)
                        guard let httpResponse = response as? HTTPURLResponse,
                            httpResponse.statusCode == 200 else {
                                throw URLError(.badServerResponse)
                            }
                        return data
                        }
                .decode(type: ResponseObject.self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
                .sink(
                    receiveCompletion : { status in
                        switch status {
                        case .finished:
                            print("Data Downloaded")
                        case .failure(let error):
                            print(error)
                        }
                    },
                    receiveValue: { responseObject in
                        print("Data received \(responseObject)")
                        self.articlesData = responseObject.articles
                    }
                )
        } else {
            print("failurl")
        }
    }
}
