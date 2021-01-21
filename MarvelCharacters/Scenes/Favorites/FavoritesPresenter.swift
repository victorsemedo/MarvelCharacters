//
//  FavoritesPresenter.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 13/01/21.
//

import UIKit

protocol FavoritesPresentationLogic {
    func presentFetchAll(response: Favorites.FecthAll.Response)
    func presentUpdateFavorite(response: Favorites.UpdateFavorite.Response)
    func presentError(error: Error)
}

final class FavoritesPresenter {
    private weak var viewController: FavoritesDisplayLogic?
    
    init(viewController: FavoritesDisplayLogic) {
        self.viewController = viewController
    }
}

// MARK: Presentation Logic Protocol
extension FavoritesPresenter: FavoritesPresentationLogic {
    
    func presentFetchAll(response: Favorites.FecthAll.Response) {
        var emptyType: CharactersEmptyType? = nil
        if response.characters.count == 0 {
            emptyType = .emptyFavorites
        }
        viewController?.displayFetchAll(viewModel: Favorites.FecthAll.ViewModel(characters: response.characters, emptyType: emptyType))
    }
    
    func presentUpdateFavorite(response: Favorites.UpdateFavorite.Response) {
        let viewModel = Favorites.UpdateFavorite.ViewModel(result: response.result, index: response.index)
        viewController?.displayUpdateFavorite(viewModel: viewModel)
    }
    
    func presentError(error: Error) {
        
    }
}

