//
//  SearchMoviesUseCase.swift
//  LeanScaleCaseStudy
//
//  Created by Mahmoud Nasser on 28/06/2022.
//

import Foundation
import Alamofire

enum SearchMoviesUseCase {
    case searchMovies(searchedText: String)
}

extension SearchMoviesUseCase: TargetType {
    var baseUrl: String {
        return NetworkingConstants.baseUrl
    }

    var path: String {
        switch self {
        case .searchMovies:
            return "games"
        }
    }

    var headers: [String: String]? {
        NetworkingConstants.headers()
    }

    var task: TaskType {
        switch self {
        case let .searchMovies(searchedText):
            return .parametersRequest(parameter: [
                "search": searchedText,
                "key": "3be8af6ebf124ffe81d90f514e59856c"], encoding: URLEncoding.default)
        }
    }

    var HTTPMethod: HTTPMethod {
        switch self {
        case .searchMovies:
            return .get
        }
    }

}

protocol SearchMoviesDelegate: AnyObject {
    func searchMovies(text: String,
                      completion: @escaping(Result<BaseNetworkResponseModel<[MovieResult]>?, NSError>) -> Void)
}

class SearchMoviesApi: BaseNetworkRequest<SearchMoviesUseCase>, SearchMoviesDelegate {

    static var shared: SearchMoviesDelegate = SearchMoviesApi()

    func searchMovies(text: String,
                      completion: @escaping (Result<BaseNetworkResponseModel<[MovieResult]>?, NSError>) -> Void) {
        fetchData(target: .searchMovies(searchedText: text), object: BaseNetworkResponseModel<[MovieResult]>.self) { result in
            completion(result)
        }
    }
}
