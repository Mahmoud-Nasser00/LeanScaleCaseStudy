//
//  FetchMoviesUseCase.swift
//  LeanScaleCaseStudy
//
//  Created by Mahmoud Nasser on 27/06/2022.
//

import Foundation
import Alamofire

enum FetchMoviesUseCase {
    case fetchMovies(pageSize: Int, page: Int)
}

extension FetchMoviesUseCase: TargetType {
    var baseUrl: String {
        return NetworkingConstants.baseUrl
    }

    var path: String {
        switch self {
        case .fetchMovies:
            return "games"
        }
    }

    var headers: [String: String]? {
        NetworkingConstants.headers()
    }

    var task: TaskType {
        switch self {
        case let .fetchMovies(pageSize, page):
            return .parametersRequest(parameter: [
                "page_size": pageSize,
                "page": page,
                "key": "3be8af6ebf124ffe81d90f514e59856c"], encoding: URLEncoding.default)
        }
    }

    var HTTPMethod: HTTPMethod {
        switch self {
        case .fetchMovies:
            return .get
        }
    }

}

protocol FetchMoviesDelegate: AnyObject {
    func fetchMovies(page: Int,
                     completion: @escaping(Result<BaseNetworkResponseModel<[MovieResult]>?, NSError>) -> Void)
}

class FetchMoviesApi: BaseNetworkRequest<FetchMoviesUseCase>, FetchMoviesDelegate {

    static var shared: FetchMoviesDelegate = FetchMoviesApi()

    func fetchMovies(page: Int,
                     completion: @escaping (Result<BaseNetworkResponseModel<[MovieResult]>?, NSError>) -> Void) {
        fetchData(target: .fetchMovies(pageSize: 10, page: page), object: BaseNetworkResponseModel<[MovieResult]>.self) { result in
            completion(result)
        }
    }
}
