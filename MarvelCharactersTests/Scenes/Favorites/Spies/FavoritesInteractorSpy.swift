//
//  FavoritesInteractorSpy.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 19/01/21.
//

@testable import MarvelCharacters

class FavoritesInteractorSpy: FavoritesDataStore {
    var fecthAllCalled = false
    var selectCharacterCalled = false
    var updateFavoriteCalled = false
    
    var selectedCharacter: Character?
}

extension FavoritesInteractorSpy: FavoritesBusinessLogic {
    
    func fecthAll(request: Favorites.FecthAll.Request) {
        fecthAllCalled = true
    }
    
    func selectCharacter(request: Favorites.SelectCharacter.Request) {
        selectCharacterCalled = true
    }
    
    func updateFavorite(request: Favorites.UpdateFavorite.Request) {
        updateFavoriteCalled = true
    }    
}
