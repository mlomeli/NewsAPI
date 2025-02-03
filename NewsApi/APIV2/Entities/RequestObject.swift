//
//  RequestObject.swift
//  NewsApi
//
//  Created by Miguel Lomeli on 1/16/25.
//

enum ExclusiveParameters {
    case sources(value: String)
    case category(value: String)
}
// TO-DO: Since we are using once request object for two endpoints. This is how we could make sure there's no
// incompatible parameters being passed.

enum QueryType {
    case topHeadlines(country: String)
    case everything(q: String)
}

struct RequestObject {
    var filters: ExclusiveParameters?
    var queryType: QueryType
    var pageSize: Int? = 10
    var page: Int?

    func toArray() -> [String: String] {
        var dict = [String: String]()
        switch queryType {
        case .topHeadlines(let country):
            dict["country"] = country
        case .everything(let q):
            dict["q"] = q
        }
        if let filters = filters {
            switch filters {
            case .sources(let value):
                dict["sources"] = value
            case .category(let value):
                dict["category"] = value
            }
        }
        if let pageSize = pageSize {
            dict["pageSize"] = "\(pageSize)"
        }
        if let page = page {
            dict["page"] = "\(page)"
        }
        return dict
    }
}
