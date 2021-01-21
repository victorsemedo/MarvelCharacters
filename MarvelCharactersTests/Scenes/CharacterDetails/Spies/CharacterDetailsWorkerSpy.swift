//
//  CharacterDetailsWorkerSpy.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 19/01/21.
//

@testable import MarvelCharacters
import UIKit

class CharacterDetailsWorkerSpy: FavoritesWorkerSpy {
    var fetchComicsCalled = false
    var fetchSeriesCalled = false
    var characterId: Int? = nil
    
    var apiResultType = WorkerSpyAPIResultType.success
}

extension CharacterDetailsWorkerSpy: CharacterDetailsWorkLogic {
    func fetchComics(byId id: Int, result: @escaping (Result<[Comic], APIError>) -> Void) {
        fetchComicsCalled = true
        characterId = id
        
        switch apiResultType {
        case .success:
            result(.success(CharacterDetailsSeeds.loadComicsSeriesResponse.comics))
        case .empty:
            result(.success([Comic]()))
        default:
            result(.failure(apiResultType.apiError))
        }
    }
    
    func fetchSeries(byId id: Int, result: @escaping (Result<[Serie], APIError>) -> Void) {
        fetchSeriesCalled = true
        characterId = id
        
        switch apiResultType {
        case .success:
            result(.success(CharacterDetailsSeeds.loadComicsSeriesResponse.series))
        case .empty:
            result(.success([Serie]()))
        default:
            result(.failure(apiResultType.apiError))
        }
    }
}
