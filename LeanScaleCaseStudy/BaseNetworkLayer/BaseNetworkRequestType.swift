//
//  BaseApiRequest.swift
//  LeanScaleCaseStudy
//
//  Created by Mahmoud Nasser on 01/08/2021.
//

import Foundation
import Alamofire

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum TaskType {
    case plainRequest
    case parametersRequest(parameter:[String:Any],encoding:ParameterEncoding)
}

protocol TargetType {
    var baseUrl: String { get }
    var path: String { get }
    var headers: [String:String]? { get }
    var task: TaskType { get }
    var HTTPMethod: HTTPMethod { get }
}
