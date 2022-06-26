//
//  BaseApiResponse.swift
//  LeanScaleCaseStudy
//
//  Created by Mahmoud Nasser on 01/08/2021.
//

import Foundation

struct BaseNetworkResponseModel<T:Codable>: Codable {
    var status:Bool?
    var message:String?
    var data:T?
    let count:Int?
    let specialityId: Int?

}

struct BaseNetworkResponseErrorModel: Codable {
    var message: String?
    var status:Bool?
}
