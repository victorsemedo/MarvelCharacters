//
//  FavoritesPresenterSpy.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 19/01/21.
//

@testable import MarvelCharacters

class FavoritesPresenterSpy {
    var presentFetchAllCalled = false
    var presentUpdateFavoriteCalled = false
    var presentErrorCalled = false

}

extension FavoritesPresenterSpy: FavoritesPresentationLogic {
    func presentFetchAll(response: Favorites.FecthAll.Response) {
        presentFetchAllCalled = true
    }
    
    func presentUpdateFavorite(response: Favorites.UpdateFavorite.Response) {
        presentUpdateFavoriteCalled = true
    }
    
    func presentError(error: Error) {
        presentErrorCalled = true
    }
}
