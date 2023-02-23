//
//  Models.swift
//  CollectionView+Combine
//
//  Created by openobject on 2023/02/22.
//

import Foundation

// MARK: - Welcome
struct Result: Codable, Hashable {
    let searchType: String
    let expression: String
    let results: [Movies]
    let errorMessage: String
}

// MARK: - Result
struct Movies: Codable, Hashable {
    let id: String
    let resultType: String
    let image: String
    let title, description: String
}

enum SearchTypeEnum: String, Codable {
    case movie = "Movie"
}
