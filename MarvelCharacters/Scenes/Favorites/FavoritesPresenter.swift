//
//  FavoritesPresenter.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 13/01/21.
//

import UIKit

protocol FavoritesPresentationLogic {
    func presentFetchAll(response: Favorites.FecthAll.Response)
}

class FavoritesPresenter {
    private weak var viewController: FavoritesDisplayLogic?
    
    init(viewController: FavoritesDisplayLogic) {
        self.viewController = viewController
    }
}

// MARK: Presentation Logic Protocol
extension FavoritesPresenter: FavoritesPresentationLogic {
    func presentFetchAll(response: Favorites.FecthAll.Response) {
        let charactersViewModel = response.characters.map { CharacterCellData(character: $0)}
        charactersViewModel.forEach { (character) in
            character.isFavorite = true
        }
        viewController?.displayFetchAll(viewModel: Favorites.FecthAll.ViewModel(characters: charactersViewModel))
    }
}

