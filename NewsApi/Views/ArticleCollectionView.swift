//
//  ArticleCollectionView.swift
//  NewsApi
//
//  Created by Miguel A Lomeli Cantu on 10/11/24.
//

import SwiftUI

struct ArticleCollectionView: View {
    let articles = Article.sampleSet()
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItems) {
                ForEach(articles) { article in
                    ArticleTeaserView(article: article)
                }
            }
        }

    }

    //viewmodel

    let gridItems = [
        GridItem(.flexible(), spacing: 10)
      ]
}

#Preview {
    ArticleCollectionView()
}
