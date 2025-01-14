//
//  Environment.swift
//  NewsApi
//
//  Created by Miguel Lomeli on 1/14/25.
//

import Foundation
import SwiftUI

extension EnvironmentValues {
    @Entry var newsApiClient: NetworkingService = NewsApiClient()
}
