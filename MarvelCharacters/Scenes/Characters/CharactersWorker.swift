//
//  CharactersWorker.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 09/01/21.
//

import UIKit

protocol CharactersWorkLogic: class {
    
    func loadNextPage(request: Characters.LoadNextPage.Request, result: @escaping (Result<Characters.LoadNextPage.Response, APIError>) -> Void)
    
    func saveFovoriteCharacter(_ character: Character)
    
    func deleteFavoriteCharacter(_ character: Character)
    
    func loadFavoriteCharacters() -> [Character]
}

// MARK: Work Logic Protocol
class CharactersWorker: CharactersWorkLogic {

    func loadNextPage(request: Characters.LoadNextPage.Request, result: @escaping (Result<Characters.LoadNextPage.Response, APIError>) -> Void) {
        APIProvider.makeRequest(MarvelAPI.characters(request.searchName, request.page)) { (providerResult: Result<Characters.LoadNextPage.Response, APIError>) in
            switch providerResult {
            case .success(let response):
                result(.success(response))
            case.failure(let error):
                result(.failure(error))
            }
        }
    }
    
    func saveFovoriteCharacter(_ character: Character) {
        MarvelDataProvider.saveFavoriteCharacter(character)
    }
    
    func deleteFavoriteCharacter(_ character: Character) {
        _ = MarvelDataProvider.deleteFavoriteCharacter(withId: character.id)
    }
    
    func loadFavoriteCharacters() -> [Character] {
        let characters = MarvelDataProvider.fetchFavoriteCharacters()
        return characters.map {$0.toCharacter()}
    }
    
}
