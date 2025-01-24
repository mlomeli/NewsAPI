//
//  ArticleView.swift
//  NewsApi
//
//  Created by Miguel A Lomeli Cantu on 11/11/24.
//

import SwiftUI

struct ArticleView: View {
    @State var article: Article

    var body: some View {
        GeometryReader { geometry in
            VStack {
                AsyncImage(url: article.urlImage) { result in
                    if let image = result.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } else {
                        ProgressView()
                    }
                }.frame(width: geometry.size.width, height: geometry.size.width*3/4).fixedSize()

                VStack(alignment: .leading) {
                    Text(article.title).modifier(Headline())
                    HStack {
                        Text(article.source?.name  ?? "").modifier(Footnote())
                        Text(article.publishedAt).modifier(Footnote())
                    }
                    if let description = article.description {
                        Text(description).modifier(Abstract())
                    }

                }.frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 5)
                    .padding(.bottom, 10)
            }.background(Color("Background"))
        }
    }
}

#Preview {
    ArticleView(article: Article.sampleSelf())
}
