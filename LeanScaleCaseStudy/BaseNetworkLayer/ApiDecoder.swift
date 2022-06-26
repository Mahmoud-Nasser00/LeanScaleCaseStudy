//
//  ApiDecoder.swift
//  LeanScaleCaseStudy
//
//  Created by Mahmoud Nasser on 01/08/2021.
//

import Foundation

class ApiDecoder<M:Codable>{
    
    typealias decodingCompletion<M:Codable> = (_ response:M?, _ error:Error?) -> Void
    
    class func decode<T:Codable>(fromData data: Data, to object: T.Type, completion: @escaping(_ response: T?, _ error: Error?) -> Void) {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let response: T = try jsonDecoder.decode(object, from: data)
            completion(response, nil)
        } catch let error {
            completion(nil, error)
            print("error from json failed to decode : \(error)")
        }
    }
    
    class func decode2<M: Codable>(fromData data:Data,
                              toObject object: M.Type, completion:@escaping decodingCompletion<M>){
        
        let decoder = JSONDecoder()
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
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

class modelEncoder<M:Codable> {
    
    typealias encodingCompletion<M:Codable> = (_ response: String?, _ error: Error?) -> Void
    
    class func encode<T:Encodable>(from model: T, completion: @escaping encodingCompletion<T>) {
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(model)
            let jsonModel = String(data: jsonData, encoding: .utf8)
            completion(jsonModel, nil)
        } catch let error {
            completion(nil, error)
        }
    }
    
}

protocol Convertable: Codable { }

extension Convertable {
    
    func convertToDict() -> [String: Any] {
        
        var dict: [String: Any] = [:]
        do {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let jsonData = try encoder.encode(self)
            dict = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [String : Any]
        } catch {
            print("error in Serialization object",error)
        }
        return dict
    }
    
}
