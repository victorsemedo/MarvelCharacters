//
//  MarvelAPI.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 10/01/21.
//

import Foundation

enum MarvelAPI {
    case characters(String?, Int)
    case character(String)
    case comics(String)
    case series(String)
}

extension MarvelAPI: HTTPRequestParams {
    
    var baseURL: String {
        return MarvelAPIConstants.BASE_URL
    }
    
    var path: String {
        switch self {
        case .characters:
            return "characters"
        case .character(let id):
            return "characters/\(id)"
        case .comics(let id):
            return "characters/\(id)/comics"
        case .series(let id):
            return "characters/\(id)/series"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .characters(let nameStartsWith, let offset):
            var parameters: [String : Any] = [MarvelAPIConstants.PARAMETER_OFFSET : offset]
            if let nameStartsWith = nameStartsWith {
                parameters[MarvelAPIConstants.PARAMETER_NAME_STARTS_WITH] = nameStartsWith
            }
            return authParameters().merging(parameters) { (current, _) in current }
        default:
            return authParameters()
        }
    }
}

extension MarvelAPI: URLRequestConvertible {
    
    func asURLRequest() throws -> URLRequest {
        guard var url = URL(string: baseURL) else {
            throw APIError.badURL
        }
        url = url.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.timeoutInterval = 10.0
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        request.httpMethod = method.rawValue
        
        if let parameters = parameters, parameters.count > 0 {
            configureUrlParameters(parameters, url: url, request: &request)
        }
        request.setValue(MarvelAPIConstants.HEADER_CONTENT_TYPE, forHTTPHeaderField: MarvelAPIConstants.HEADER_CONTENT_TYPE_KEY)
        return request
    }
}


private extension MarvelAPI {
    
    func authParameters() -> [String : Any] {
        let timestamp = Date().timeIntervalSince1970.description
        return [MarvelAPIConstants.PARAMETER_PUBLIC_KEY: MarvelAPIConstants.PUBLIC_KEY,
                MarvelAPIConstants.PARAMETER_TIMESTAMP: timestamp,
                MarvelAPIConstants.PARAMETER_HASH: hash(timestamp: timestamp)]
    }
    
    func hash(timestamp ts: String) -> String {
        return "\(ts)\(MarvelAPIConstants.PRIVATE_KEY)\(MarvelAPIConstants.PUBLIC_KEY)".md5()
    }
    
    
    func configureUrlParameters(_ parameters: [String: Any], url: URL, request: inout URLRequest) {
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            urlComponents.queryItems = [URLQueryItem]()
            
            parameters.forEach { (key, value) in
                let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            
            request.url = urlComponents.url
        }
    }
    
}
