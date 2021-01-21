//
//  FavoritesPresenterSpy.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 19/01/21.
//

@testable import MarvelCharacters

class FavoritesPresenterSpy {
    var presentFetchAllResponse: Favorites.FecthAll.Response? = nil
    var presentUpdateFavoriteResponse: Favorites.UpdateFavorite.Response? = nil
    var presentError: Error? = nil
}

extension FavoritesPresenterSpy: FavoritesPresentationLogic {
    func presentFetchAll(response: Favorites.FecthAll.Response) {
        presentFetchAllResponse = response
    }
    
    func presentUpdateFavorite(response: Favorites.UpdateFavorite.Response) {
        presentUpdateFavoriteResponse = response
    }
    
    func presentError(error: Error) {
        presentError = error
    }
}
