//
//  CharactersInteractorSpy.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 19/01/21.
//

@testable import MarvelCharacters

class CharactersInteractorSpy: CharactersDataStore {
    var loadNextPageRequest: Characters.LoadNextPage.Request? = nil
    var reloadFavoritesRequest: Characters.ReloadFavorites.Request? = nil
    var updateFavoriteRequest: Characters.UpdateFavorite.Request? = nil
    var selectCharacterRequest: Characters.SelectCharacter.Request? = nil
    
    var selectedCharacterIndex: Int? = nil
    var selectedCharacter: Character?
}

extension CharactersInteractorSpy: CharactersBusinessLogic {
      
    func loadNextPage(request: Characters.LoadNextPage.Request) {
        loadNextPageRequest = request
    }
    
    func reloadFavorites(request: Characters.ReloadFavorites.Request) {
        reloadFavoritesRequest = request
    }
    
    func updateFavorite(request: Characters.UpdateFavorite.Request) {
        updateFavoriteRequest = request
    }
    
    func selectCharacter(request: Characters.SelectCharacter.Request) {
        selectCharacterRequest = request
    }
}
