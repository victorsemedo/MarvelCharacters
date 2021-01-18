//
//  APIError.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 10/01/21.
//

import Foundation

enum APIError {
    case noConnection
    case decodeObject
    case badURL
    case unknown
}

extension APIError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .noConnection:
            return Strings.errorNoConnection.localizable
        default:
            return Strings.errorUnknown.localizable
        }
    }
}
