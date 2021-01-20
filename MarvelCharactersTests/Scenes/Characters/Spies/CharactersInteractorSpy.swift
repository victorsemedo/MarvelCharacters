//
//  CharactersInteractorSpy.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 19/01/21.
//

@testable import MarvelCharacters

class CharactersInteractorSpy: CharactersDataStore {
    var loadNextPageCalled = false
    var reloadFavoritesCalled = false
    var updateFavoriteCalled = false
    var selectCharacterCalled = false
    
    var selectedCharacterIndex: Int? = nil
    
    var selectedCharacter: Character?
}

extension CharactersInteractorSpy: CharactersBusinessLogic {
      
    func loadNextPage(request: Characters.LoadNextPage.Request) {
        loadNextPageCalled = true
    }
    
    func reloadFavorites(request: Characters.ReloadFavorites.Request) {
        reloadFavoritesCalled = true
    }
    
    func updateFavorite(request: Characters.UpdateFavorite.Request) {
        updateFavoriteCalled = true
    }
    
    func selectCharacter(request: Characters.SelectCharacter.Request) {
        selectCharacterCalled = false
    }
}
