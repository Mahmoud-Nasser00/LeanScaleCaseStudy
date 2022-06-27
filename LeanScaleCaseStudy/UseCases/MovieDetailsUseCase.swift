//
//  MovieDetailsUseCase.swift
//  LeanScaleCaseStudy
//
//  Created by Mahmoud Nasser on 28/06/2022.
//

import Foundation
import Alamofire

enum FetchMovieDetailsUseCase {
    case fetchMovieDetails(id: Int)
}

extension FetchMovieDetailsUseCase: TargetType {
    var baseUrl: String {
        return NetworkingConstants.baseUrl
    }

    var path: String {
        switch self {
        case let .fetchMovieDetails(id):
            return "games/\(id)"
        }
    }

    var headers: [String: String]? {
        NetworkingConstants.headers()
    }

    var task: TaskType {
        switch self {
        case .fetchMovieDetails:
            return .parametersRequest(parameter: ["key": "3be8af6ebf124ffe81d90f514e59856c"], encoding: URLEncoding.default)
        }
    }

    var HTTPMethod: HTTPMethod {
        switch self {
        case .fetchMovieDetails:
            return .get
        }
    }

}

protocol FetchMovieDetailsDelegate: AnyObject {
    func fetchMovieDetails(id: Int,
                           completion: @escaping(Result<MovieDetails?, NSError>) -> Void)
}

class FetchMovieDetailsApi: BaseNetworkRequest<FetchMovieDetailsUseCase>, FetchMovieDetailsDelegate {

    static var shared: FetchMovieDetailsDelegate = FetchMovieDetailsApi()

    func fetchMovieDetails(id: Int,
                           completion: @escaping (Result<MovieDetails?, NSError>) -> Void) {
        fetchData(target: .fetchMovieDetails(id: id), object: MovieDetails.self) { result in
            completion(result)
        }
    }
}
