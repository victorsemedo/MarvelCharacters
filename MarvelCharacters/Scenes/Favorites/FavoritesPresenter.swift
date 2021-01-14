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
        let charactersViewModel: [CharacterCellData] = response.characters.map {
            var image: UIImage?
            if let data = $0.img {
                image = UIImage(data: data)
            }
            return CharacterCellData(character: $0.toCharacter(), image: image, isFavorite: true)
        }
        viewController?.displayFetchAll(viewModel: Favorites.FecthAll.ViewModel(characters: charactersViewModel))
    }
}

