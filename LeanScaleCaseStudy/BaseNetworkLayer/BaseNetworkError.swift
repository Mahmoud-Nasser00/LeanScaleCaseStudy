//
//  BaseNetworkError.swift
//  LeanScaleCaseStudy
//
//  Created by Mahmoud Nasser on 01/08/2021.
//

import Foundation

struct NetworkErrorMessage {
    static let genericError = "Something went wrong, Please try again later."
    static let noInternetConnection = "The Internet connection appears to be offline."
    static let requestTimeOut = "Request Timeout, Please try again later."
    static let badServerResponse = "Bad Server Response, Please try again later."
    static let badUrl = "There is something Wrong with Url"
    static let decodingError = "Couldn't decode Json response"
}
