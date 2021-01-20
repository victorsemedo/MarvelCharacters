//
//  CharactersWorkerSpy.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 19/01/21.
//

@testable import MarvelCharacters
import UIKit

enum CharactersWorkerAPIResultType {
    case success
    case empty
    case noConnection
    case decodeObject
    case badURL
    case unknown
}

class CharactersWorkerSpy: FavoritesWorkerSpy {
    
    var apiResultType = CharactersWorkerAPIResultType.success

    var loadNextPageCalled = false
    
}

extension CharactersWorkerSpy: CharactersWorkLogic {
    
    func loadNextPage(request: Characters.LoadNextPage.Request, result: @escaping (Result<Characters.LoadNextPage.Response, APIError>) -> Void) {
        loadNextPageCalled = true
        
        switch apiResultType {
        case .success:
            result(.success(CharactersSeeds.loadNextPage))
        case .empty:
            result(.success(CharactersSeeds.loadNextPageEmpty))
        case .noConnection:
            result(.failure(APIError.noConnection))
        case .decodeObject:
            result(.failure(APIError.decodeObject))
        case .badURL:
            result(.failure(APIError.badURL))
        case .unknown:
            result(.failure(APIError.unknown))
        }
    }
    
}
