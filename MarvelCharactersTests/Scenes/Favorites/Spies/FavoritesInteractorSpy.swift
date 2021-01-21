//
//  FavoritesInteractorSpy.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 19/01/21.
//

@testable import MarvelCharacters

class FavoritesInteractorSpy: FavoritesDataStore {
    var fecthAllRequest: Favorites.FecthAll.Request? = nil
    var selectCharacterRequest: Favorites.SelectCharacter.Request? = nil
    var updateFavoriteRequest: Favorites.UpdateFavorite.Request? = nil
    
    var selectedCharacter: Character?
}

extension FavoritesInteractorSpy: FavoritesBusinessLogic {
    
    func fecthAll(request: Favorites.FecthAll.Request) {
        fecthAllRequest = request
    }
    
    func selectCharacter(request: Favorites.SelectCharacter.Request) {
        selectCharacterRequest = request
    }
    
    func updateFavorite(request: Favorites.UpdateFavorite.Request) {
        updateFavoriteRequest = request
    }    
}
