//
//  CharacterDetailsWorkerSpy.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 19/01/21.
//

@testable import MarvelCharacters
import UIKit

class CharacterDetailsWorkerSpy {
    var fetchComicsCalled = false
    var fetchSeriesCalled = false
    var saveFovoriteCharacterCalled = false
    var deleteFavoriteCharacterCalled = false
    var loadFavoriteCharactersCalled = false
}

extension CharacterDetailsWorkerSpy: CharacterDetailsWorkLogic {
    func fetchComics(byId id: Int, result: @escaping (Result<[Comic], APIError>) -> Void) {
        fetchComicsCalled = true
    }
    
    func fetchSeries(byId id: Int, result: @escaping (Result<[Serie], APIError>) -> Void) {
        fetchSeriesCalled = true
    }
    
    func saveFovoriteCharacter(_ character: Character, image: UIImage?, result: @escaping (Result<Bool, DataProviderError>) -> Void) {
        saveFovoriteCharacterCalled = true
    }
    
    func deleteFavoriteCharacter(_ character: Character, result: @escaping (Result<Bool, DataProviderError>) -> Void) {
        deleteFavoriteCharacterCalled = true
    }
    
    func loadFavoriteCharacters(byName name: String?, result: @escaping (Result<[Character], DataProviderError>) -> Void) {
        loadFavoriteCharactersCalled = true
    }

}
