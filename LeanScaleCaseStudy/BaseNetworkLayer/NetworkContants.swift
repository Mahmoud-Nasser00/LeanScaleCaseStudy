//
//  NetworkContants.swift
//  LeanScaleCaseStudy
//
//  Created by Mahmoud Nasser on 15/06/2022.
//

import Foundation

class NetworkingConstants {
    
    static let baseUrl =  BuildConfiguration.shared.baseUrl
    
    static func headers() -> [String:String] {
        return
            [
                "Content-Type": "application/json",
                "Accept": "application/json",
        ]
    }
    
    static func createParamsDict(dict:[String:Any?])-> [String:Any] {
        var paramsDict = [String:Any]()
        let _ = dict.map { key,value in
            if value != nil {
                paramsDict[key] = value
            }
        }
        return paramsDict
    }
}
