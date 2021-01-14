//
//  FavoritesWorker.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 13/01/21.
//

import UIKit

enum FavoritesWorkerError: Error {
    case systemUnavailable
    case custom(message: String)
    
    var localizedDescription: String {
        switch self {
        case .systemUnavailable:
            return "Sistema Indisponível"
        case .custom(let message):
            return message
        }
    }
}

protocol FavoritesWorkLogic: class {
    func fetchSomething(request: Favorites.FecthAll.Request,
                        result: @escaping (Result<Favorites.FecthAll.Response, FavoritesWorkerError>) -> Void)
}

// MARK: Work Logic Protocol
class FavoritesWorker: FavoritesWorkLogic {
    func fetchSomething(request: Favorites.FecthAll.Request,
                        result: @escaping (Result<Favorites.FecthAll.Response, FavoritesWorkerError>) -> Void) {
    }
}
