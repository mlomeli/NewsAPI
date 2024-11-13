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
        GeometryReader { geometry in
            VStack {
                AsyncImage(url: article.urlToImage) { result in
                    if let image = result.image {
                        image
                            .resizable()
                    } else {
                        ProgressView()
                    }
                }.frame(width: geometry.size.width, height: geometry.size.width*3/4)

                VStack(alignment: .leading) {
                    Text(article.title).modifier(Headline())
                    HStack {
                        Text(article.source?.name  ?? "").modifier(Footnote())
                        Spacer()
                        Text(article.publishedAt).modifier(Footnote())
                    }

                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .padding(.horizontal, 5)
                    .padding(.bottom, 10)
            }.background(Color("Background"))
        }
    }
}

#Preview {
    ArticleTeaserView(article: Article.sampleSelf()).background(Color.purple).frame(width: 350, height: 350).clipped()
}
