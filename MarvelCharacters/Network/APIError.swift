//
//  APIError.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 10/01/21.
//

import Foundation

enum APIError: Error {
    case badURL
    case noConnection
    case decodeObject
    case unowned
}
