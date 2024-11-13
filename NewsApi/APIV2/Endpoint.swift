//
//  Endpoint.swift
//  NewsApi
//
//  Created by Miguel A Lomeli Cantu on 12/11/24.
//

public enum Endpoint {
    case topHeadlines
    case searchTerm

    func path() -> String {
        switch self {
        case .topHeadlines:
            return "/v2/top-headlines"
        case .searchTerm:
            return "/v2/everything"
        }
    }

}
