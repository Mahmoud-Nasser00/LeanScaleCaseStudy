//
//  MovieModel.swift
//  LeanScaleCaseStudy
//
//  Created by Mahmoud Nasser on 27/06/2022.
//

import Foundation

// MARK: - Welcome
struct Movie: Codable {
    let count: Int
    let next: String
//    let previous: JSONNull?
    let results: [MovieResult]
//    let seoTitle, seoDescription, seoKeywords, seoH1: String
//    let noindex, nofollow: Bool
//    let welcomeDescription: String
//    let filters: Filters
//    let nofollowCollections: [String]
}

// struct Filters: Codable {
//    let years: [FiltersYear]
// }

// struct FiltersYear: Codable {
//    let from, to: Int
//    let filter: String
//    let decade: Int
//    let years: [YearYear]
//    let nofollow: Bool
//    let count: Int
// }

// struct YearYear: Codable {
//    let year, count: Int
//    let nofollow: Bool
// }

// MARK: - Result
struct MovieResult: Codable {
    let id: Int
    let name, backgroundImage: String
    let metacritic: Int?
    let genres: [Genre]
}

struct Genre: Codable {
    let id: Int
    let name: String
}
