//
//  ArticleTeaserView.swift
//  NewsApi
//
//  Created by Miguel A Lomeli Cantu on 09/11/24.
//

import SwiftUI

struct ArticleTeaserView: View {
    @State var article: Article

    var body: some View {
        VStack {
            AsyncImage(url: article.urlToImage) { result in
                if let image = result.image {
                    image
                        .resizable()
                } else {
                    ProgressView()
                }
            }.frame(height: 200)

            VStack(alignment: .leading) {
                Text(article.title).modifier(Headline())
                if let description = article.description {
                    Text(description).modifier(Abstract())
                }
                HStack {
                    Text(article.source?.name  ?? "").modifier(Footnote())
                    Spacer()
                    Text(article.publishedAt.formatted()).modifier(Footnote())
                }

            }.padding(.horizontal, 5)
                .padding(.bottom, 10)
        }.background(Color("GroupBackground"))
    }
}

#Preview {
    ArticleTeaserView(article: Article.sampleSelf()).frame(width: 350, height: 500)
}
