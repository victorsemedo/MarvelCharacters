//
//  FavoritesViewControllerSpy.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 19/01/21.
//

@testable import MarvelCharacters

class FavoritesViewControllerSpy: UIViewControllerSpy {
    var displayFetchAllCalled = false
    var displayUpdateFavoriteCalled = false
}

extension FavoritesViewControllerSpy: FavoritesDisplayLogic {
    
    func displayFetchAll(viewModel: Favorites.FecthAll.ViewModel) {
        displayFetchAllCalled = true
    }
    
    func displayUpdateFavorite(viewModel: Favorites.UpdateFavorite.ViewModel) {
        displayUpdateFavoriteCalled = true
    }
}
