//
//  FilterArticleCollectionView.swift
//  NewsApi
//
//  Created by Miguel Lomeli on 1/31/25.
//

import SwiftUI

struct FilterArticleCollectionView<ViewModel>: View where ViewModel: AbstractArticlesViewModel {
    @State var query = ""
    @FocusState var isFocused: Bool
    @StateObject var viewModel: ViewModel
    var body: some View {
        ArticleCollectionView(viewModel: viewModel)
            .searchable(text: $query)
            .onSubmit(of: .search) {
                viewModel.type = .everything(q: query)
                viewModel.fetchArticles()
            }
    }
}

#Preview {
    FilterArticleCollectionView(viewModel: StubArticleViewModel())
}
