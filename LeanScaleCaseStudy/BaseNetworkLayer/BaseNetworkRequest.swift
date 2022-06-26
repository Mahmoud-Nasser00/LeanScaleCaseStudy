//
//  BaseLayer.swift
//  LeanScaleCaseStudy
//
//  Created by Mahmoud Nasser on 01/08/2021.
//

import Foundation
import Alamofire
import UIKit

class BaseNetworkRequest<T: TargetType> {
    
    typealias NetworkResultCompletion<M: Decodable> = (Result<M?, NSError>) -> Void
    typealias NetworkCompletionError = (NSError) -> Void
    typealias DecodingCompletion<M: Codable> = (_ response: M?, _ error: NSError?) -> Void
    typealias UnAuthorizedCompletion = (NSError) -> Void
    
    func fetchData<M: Codable>(target: T, object:M.Type, snakeCase:Int = 0, completion: @escaping NetworkResultCompletion<M>) {
        
        let method = Alamofire.HTTPMethod(rawValue: target.HTTPMethod.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let params = buildParams(task: target.task)
        
        AF.request(target.baseUrl + target.path, method: method, parameters: params.params, encoding: params.encodingType, headers: headers) {
            $0.timeoutInterval = 15
        }.response { [weak self] response in
            
            print("status code -----------:> \(response.response?.statusCode ?? 0)")
            print("url is -----------:> \(target.baseUrl)\(target.path)")
            print("parameters is -----------:> \(params)")
            print("headers:-----------:>\(headers)")
            
            guard response.error == nil else {
                completion(.failure(response.error! as NSError))
                return
            }
            
            self?.handleUrlStatusCode(responseData: response.data,code: response.response?.statusCode) { isSuccess,error  in
                
                guard isSuccess else {
                    if error == "Unaunthenticated" {
                        completion(.failure(NSError(domain: target.baseUrl, code: 401, userInfo: [NSLocalizedDescriptionKey:error ?? ""])))
                        
                    }
                    completion(.failure(NSError(domain: target.baseUrl, code: 0, userInfo: [NSLocalizedDescriptionKey:error ?? ""])))
                    return
                }
                
                guard let data = response.data else {
                    completion(.failure(NSError(domain: target.baseUrl, code: 0, userInfo: [NSLocalizedDescriptionKey: "not valid response!"])))
                    return
                }
                
                self?.decode(fromData: data, toObject: object, snakeCase: snakeCase, completion: { object, error in
                    guard let object = object , error == nil else {
                        completion(.failure(error!))
                        return
                    }
                    print("result is:-----------:>\(object)")
                    completion(.success(object))
                })
                
            }
            
        }
        
    }
    
    private func buildParams(task:TaskType)->(params:[String:Any],encodingType:ParameterEncoding) {
        switch task {
        case .plainRequest:
            return ([:],URLEncoding.default)
            
        case .parametersRequest(parameter: let parameters, encoding: let encoding):
            return (parameters, encoding)
        }
    }
    
    private func handleUrlStatusCode(responseData:Data?,code:Int?, completion:@escaping(Bool,String?) -> Void) {
        
        guard let statusCode = code else {
            print("There is no status code")
            completion(false, "There is no status code")
            return
        }
        
        switch statusCode {
        case 200:
            completion(true,nil)
        case 401:
            // Not Authorized
            guard let data = responseData else {
                completion(false, "\(code!) \(NetworkErrorMessage.badUrl)")
                return
            }
            decode(fromData: data, toObject: BaseNetworkResponseErrorModel.self) { result, _ in
                completion(false, result?.message)
            }
            
        case 403:
            completion(true,nil)
            
        case 422:
            guard let data = responseData else {
                completion(false, "\(code!) \(NetworkErrorMessage.badUrl)")
                return
            }
            decode(fromData: data, toObject: BaseNetworkResponseErrorModel.self) { result, _ in
                completion(false, result?.message)
            }
            
        case 500:
            completion(false, "\(code ?? 500) \(NetworkErrorMessage.badServerResponse)")
            
        default:
            completion(false, "\(code ?? -1) \(NetworkErrorMessage.badServerResponse)")
        }
    }
    
    private func handleUrlError(_ target:T, error:Error?,completion: @escaping NetworkCompletionError) {
        guard let error = error as? URLError else {
            print("there is url error")
            let error = NSError(domain: target.baseUrl, code: 0, userInfo: [NSLocalizedDescriptionKey: NetworkErrorMessage.noInternetConnection])
            completion(error)
            return
        }
        
        switch error.code {
        case .networkConnectionLost:
            let error = NSError(domain: target.baseUrl, code: 0, userInfo: [NSLocalizedDescriptionKey: NetworkErrorMessage.noInternetConnection])
            completion(error)
            return
            
        case .timedOut:
            let error = NSError(domain: target.baseUrl, code: 0, userInfo: [NSLocalizedDescriptionKey: NetworkErrorMessage.requestTimeOut])
            completion(error)
            return
            
        case .notConnectedToInternet:
            let error = NSError(domain: target.baseUrl, code: 0, userInfo: [NSLocalizedDescriptionKey:NetworkErrorMessage.noInternetConnection])
            completion(error)
            return
            
        case .badServerResponse:
            let error = NSError(domain: target.baseUrl, code: 0, userInfo: [NSLocalizedDescriptionKey:NetworkErrorMessage.badServerResponse])
            completion(error)
            return
            
        case .badURL:
            let error = NSError(domain: target.baseUrl, code: 0, userInfo: [NSLocalizedDescriptionKey:NetworkErrorMessage.badUrl])
            completion(error)
            return
            
        default:
            let error = NSError(domain: target.baseUrl, code: 0, userInfo: [NSLocalizedDescriptionKey:NetworkErrorMessage.genericError])
            completion(error)
            return
        }
        
    }
    
    private func decode<M:Codable>(fromData data: Data,
                                   toObject object: M.Type, snakeCase: Int = 0, completion: @escaping DecodingCompletion<M>) {
        let decoder = JSONDecoder()
        snakeCase == 0 ? (decoder.keyDecodingStrategy = .convertFromSnakeCase) : ()
        do {
            let model:M = try decoder.decode(object, from: data)
            completion(model,nil)
        } catch let error {
            print("decodingError:- \(error)")
            let decodingError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : NetworkErrorMessage.decodingError])
            completion(nil,decodingError)
        }
    }
}
