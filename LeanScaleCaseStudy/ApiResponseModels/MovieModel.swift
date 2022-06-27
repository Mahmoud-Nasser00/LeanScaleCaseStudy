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
    let slug, name, released: String
    let tba: Bool
    let backgroundImage: String
    let rating: Double
    let ratingTop: Int
    let ratings: [Rating]
    let ratingsCount, reviewsTextCount, added: Int
    let addedByStatus: AddedByStatus
    let metacritic, playtime, suggestionsCount: Int?
    let updated: String
//    let userGame: JSONNull?
    let reviewsCount: Int
    let saturatedColor, dominantColor: Color
//    let platforms: [PlatformElement]
//    let parentPlatforms: [ParentPlatform]
    let genres: [Genre]
//    let stores: [Store]
//    let clip: JSONNull?
//    let tags: [Genre]
//    let esrbRating: EsrbRating
    let shortScreenshots: [ShortScreenshot]
}

struct AddedByStatus: Codable {
    let yet, owned, beaten, toplay: Int
    let dropped, playing: Int
}

enum Color: String, Codable {
    case the0F0F0F = "0f0f0f"
}

struct EsrbRating: Codable {
    let id: Int
    let name, slug: String
}

struct Genre: Codable {
    let id: Int
    let name, slug: String
    let gamesCount: Int
    let imageBackground: String
    let domain: String?
    let language: Language?
}

enum Language: String, Codable {
    case eng
}

struct ParentPlatform: Codable {
    let platform: EsrbRating
}

struct Rating: Codable {
    let id: Int
    let title: Title
    let count: Int
    let percent: Double
}

enum Title: String, Codable {
    case exceptional
    case meh
    case recommended
    case skip
}

struct ShortScreenshot: Codable {
    let id: Int
    let image: String
}

struct Store: Codable {
    let id: Int
    let store: Genre
}
