//
//  ArticleTeaserView.swift
//  NewsApi
//
//  Created by Miguel A Lomeli Cantu on 09/11/24.
//

import SwiftUI

struct ArticleTeaserView: View {
    let article: Article
    var body: some View {
        HStack {
            AsyncImage(url: article.urlToImage){ result in
                if let image = result.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else {
                    Image("camera")
                }
            }
                .frame(width: 200, height: 200).clipped()
            Text(article.title).font(.system(size: 16, weight: .bold))
        }
    }
}

#Preview {
    ArticleTeaserView(article: Article.sampleSelf())
}
