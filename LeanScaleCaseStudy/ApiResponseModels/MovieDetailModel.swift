//
//  MovieDetailModel.swift
//  LeanScaleCaseStudy
//
//  Created by Mahmoud Nasser on 28/06/2022.
//

import Foundation

struct MovieDetails: Codable {
    let id: Int
    let name, description: String
    let website: String
    let redditUrl: String
    let descriptionRaw: String
    let backgroundImage: String
}
