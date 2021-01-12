//
//  APIProvider.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 10/01/21.
//

import Foundation

class APIProvider {
    
    static func makeRequest<T:Codable>(_ request: HTTPRequestParams, completion: @escaping (Result<T, APIError>) -> Void) {
        let session = URLSession.shared
        do {
            let request = try request.asURLRequest()
            let task = session.dataTask(with: request) { (data, response, error) in
                if let data = data, let responseData: T = APIProvider.decodeFormData(data: data) {
                    DispatchQueue.main.async {completion(.success(responseData))}
                } else {
                    DispatchQueue.main.async {completion(.failure(.decodeObject))}
                }
            }
            task.resume()
        } catch let error {
            guard let error = error as? APIError else {
                DispatchQueue.main.async {completion(.failure(.unowned))}
                return
            }
            DispatchQueue.main.async {completion(.failure(error))}
        }
    }
    
    static func decodeFormData<T:Codable>(data: Data) -> T? {
        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(T.self, from: data)
            return response
        } catch {
            return nil
        }
    }
    
}
