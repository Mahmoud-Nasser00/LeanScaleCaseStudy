//
//  MovieModel.swift
//  LeanScaleCaseStudy
//
//  Created by Mahmoud Nasser on 27/06/2022.
//

import Foundation

struct MovieResponse: Codable {
    let count: Int
    let next: String
    let results: [MovieResult]
}

struct MovieResult: Codable {
    let id: Int
    let name, backgroundImage: String
    let metacritic: Int?
    let genres: [Genre]

    var isOpened: Bool?

    func convertToMovie() -> Movie {
        let genres = self.genres.map { $0.name }.joined(separator: ", ")
        let meta = metacritic ?? 0
        
        return Movie(id: self.id,
                     name: self.name,
                     backgroundImage: self.backgroundImage,
                     metacritic: meta,
                     genres: genres,
                     isOpened: self.isOpened ?? false,
                     isFavorite: false)
    }
}

struct Genre: Codable {
    let id: Int
    let name: String
}

struct Movie {
    let id: Int
    let name, backgroundImage: String
    let metacritic: Int
    let genres: String

    var isOpened: Bool
    var isFavorite: Bool
}
