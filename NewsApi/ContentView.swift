//
//  ContentView.swift
//  NewsApi
//
//  Created by Miguel A Lomeli Cantu on 04/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ArticleCollectionView() .navigationTitle("News")
        }
    }
}

#Preview {
    ContentView()
}
