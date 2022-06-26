//
//  EnviromentsManager.swift
//  LeanScaleCaseStudy
//
//  Created by Mahmoud Nasser on 20/04/2022.
//  Copyright © 2022 Mahmoud Nasser. All rights reserved.
//

import Foundation

enum Environment: String {
    case debug = "Debug"
    case release = "Release"
}

class BuildConfiguration {
    static let shared = BuildConfiguration()
    var environment: Environment
    
    var baseUrl : String {
        switch environment {
        case .debug:
            return "https://api.rawg.io/api/"
        case .release:
            return  "https://api.rawg.io/api/"
        }
    }
    
    init() {
        let currentConfig = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String
        environment = Environment(rawValue: currentConfig!)!
    }
}
