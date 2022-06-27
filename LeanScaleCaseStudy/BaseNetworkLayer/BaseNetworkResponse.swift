//
//  BaseApiResponse.swift
//  LeanScaleCaseStudy
//
//  Created by Mahmoud Nasser on 01/08/2021.
//

import Foundation

struct BaseNetworkResponseModel<T: Codable>: Codable {
    var results: T?
    var next: String?
    var previos: String?
    let count: Int
}

struct BaseNetworkResponseErrorModel: Codable {
    var message: String?
    var status: Bool?
}
