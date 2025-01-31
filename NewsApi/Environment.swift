//
//  Environment.swift
//  NewsApi
//
//  Created by Miguel Lomeli on 1/14/25.
//

import Foundation
import SwiftUI

extension EnvironmentValues {
#if TARGET_IPHONE_SIMULATOR
    @Entry var newsApiClient: NetworkingService = NewsApiClient.shared
#else
    @Entry var newsApiClient: NetworkingService = NewsApiClient.shared
#endif
}
