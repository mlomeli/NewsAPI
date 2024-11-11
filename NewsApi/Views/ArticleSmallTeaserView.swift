//
//  ArticleSmallTeaserView.swift
//  NewsApi
//
//  Created by Miguel A Lomeli Cantu on 10/11/24.
//


import SwiftUI

struct ArticleSmallTeaserView: View {
    @State var article: Article

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(article.title).modifier(Headline())
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .padding(.horizontal, 0)
                .padding(.bottom, 10)

            AsyncImage(url: article.urlToImage) { result in
                if let image = result.image {
                    image
                        .resizable()
                } else {
                    ProgressView()
                }
            }.frame(width: 100, height:100)
        }.background(Color("GroupBackground")).frame(maxHeight: .infinity)
    }
}

#Preview {
    ArticleSmallTeaserView(article: Article.sampleSelf()).frame(width: 350, height: 100)
}
