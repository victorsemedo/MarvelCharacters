//
//  DataProviderError.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 17/01/21.
//

import Foundation

enum DataProviderError {
    case save
    case fetch
    case delete
    case unknown
}

extension DataProviderError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .save:
            return Strings.errorNoConnection.localizable
        case .fetch:
            return Strings.errorNoConnection.localizable
        case .delete:
            return Strings.errorNoConnection.localizable
        default:
            return Strings.errorUnknown.localizable
        }
    }
}
