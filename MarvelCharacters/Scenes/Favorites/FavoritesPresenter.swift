//
//  FavoritesPresenter.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 13/01/21.
//

import UIKit

protocol FavoritesPresentationLogic {
    func presentSomething(response: Favorites.Something.Response)
}

class FavoritesPresenter {
    private weak var viewController: FavoritesDisplayLogic?
    
    init(viewController: FavoritesDisplayLogic) {
        self.viewController = viewController
    }
}

// MARK: Presentation Logic Protocol
extension FavoritesPresenter: FavoritesPresentationLogic {
    func presentSomething(response: Favorites.Something.Response) {
    }
}
