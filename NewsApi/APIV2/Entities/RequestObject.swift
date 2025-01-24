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

struct RequestObject {
    var countryCode: String? = "us"
    var filters: ExclusiveParameters?
    var q: String?
    var pageSize: Int? = 10
    var page: Int?

    func toArray() -> [String: String] {
        var dict = [String: String]()
        if let countryCode = countryCode {
            dict["country"] = countryCode
        }
        if let filters = filters {
            switch filters {
            case .sources(let value):
                dict["sources"] = value
            case .category(let value):
                dict["category"] = value
            }
        }
        if let q = q {
            dict["q"] = q
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
