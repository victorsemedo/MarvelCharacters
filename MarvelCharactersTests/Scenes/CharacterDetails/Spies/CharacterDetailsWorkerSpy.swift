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
}

extension CharacterDetailsWorkerSpy: CharacterDetailsWorkLogic {
    func fetchComics(byId id: Int, result: @escaping (Result<[Comic], APIError>) -> Void) {
        fetchComicsCalled = true
    }
    
    func fetchSeries(byId id: Int, result: @escaping (Result<[Serie], APIError>) -> Void) {
        fetchSeriesCalled = true
    }
}
