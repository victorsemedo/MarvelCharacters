//
//  CharactersWorkerSpy.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 19/01/21.
//

@testable import MarvelCharacters
import UIKit

enum WorkerSpyAPIResultType {
    case success
    case empty
    case noConnection
    case decodeObject
    case badURL
    case unknown
    
    var apiError: APIError {
        switch self {
        case .noConnection:
            return .noConnection
        case .decodeObject:
            return .decodeObject
        case .badURL:
            return .badURL
        default:
            return .noConnection
        }
    }
}
class CharactersWorkerSpy: FavoritesWorkerSpy {
    
    var apiResultType = WorkerSpyAPIResultType.success

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
        default:
            result(.failure(apiResultType.apiError))
        }
    }
}
