//
//  ArticleTeaserView.swift
//  NewsApi
//
//  Created by Miguel A Lomeli Cantu on 09/11/24.
//

import SwiftUI

struct ArticleTeaserView: View {
    @State var article: Article
    @State private var teaserHeight: CGFloat = 0
    var body: some View {
        GeometryReader { geometry in
            VStack {
                AsyncImage(url: article.urlToImage) { result in
                    if let image = result.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } else {
                        ProgressView()
                    }
                }.frame(width: geometry.size.width, height: geometry.size.width*3/4).clipped()
                VStack(alignment:.leading) {
                    Text(article.title).modifier(Headline())
                        .lineLimit(3)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                    HStack {
                        Text(article.source?.name  ?? "").modifier(Footnote())
                        Spacer()
                        Text(article.publishedAt).modifier(Footnote())
                    }.padding(.vertical, 5)
                }
                    .padding(.horizontal, 5)
            }.background(
                GeometryReader { vgeo in
                    Color("Background").preference(key: TeaserHeightPreferenceKey.self, value: vgeo.size.height)
                }
            ).onPreferenceChange(TeaserHeightPreferenceKey.self) { value in
                self.teaserHeight = value
            }
        }.frame(height: teaserHeight)
    }
}
// Geometry Reader will take all available space in the View and it will prevent the parent from properly sizing it.
struct TeaserHeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = CGFloat(0)
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value+=nextValue()
    }
}

#Preview {
    ArticleTeaserView(article: Article.sampleSelf())
}
