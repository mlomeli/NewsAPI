//
//  TTex.swift
//  NewsApi
//
//  This class mainly exist as scaffolding to maintain the consistency
//  required of News media regarding theyr typography of choice.
//  Created by Miguel A Lomeli Cantu on 09/11/24.
//
import SwiftUI

struct TitleH1: ViewModifier {
  func body(content: Content) -> some View {
      return content
          .font(.largeTitle)
  }
}

struct TitleH2: ViewModifier {
  func body(content: Content) -> some View {
      return content
          .font(.title)
  }
}

struct Headline: ViewModifier {
  func body(content: Content) -> some View {
      return content
          .font(.headline)
          .foregroundColor(Color("Text"))
          .padding(.vertical, 5)
  }
}

struct Subheadline: ViewModifier {
  func body(content: Content) -> some View {
      return content
          .font(.subheadline)
  }
}

struct Abstract: ViewModifier {
  func body(content: Content) -> some View {
      return content
          .font(.body)
          .foregroundColor(Color("TextSecondary"))
          .padding(.bottom,5)
  }
}

struct Footnote: ViewModifier {
  func body(content: Content) -> some View {
      return content
          .font(.footnote)
          .foregroundColor(Color("TextTertiary"))
  }
}


