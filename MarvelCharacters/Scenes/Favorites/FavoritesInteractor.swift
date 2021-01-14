//
//  FavoritesInteractor.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 13/01/21.
//

import UIKit

protocol FavoritesBusinessLogic {
    func fecthAll(request: Favorites.FecthAll.Request)
}

protocol FavoritesDataStore {
}

class FavoritesInteractor: FavoritesDataStore {
    private var presenter: FavoritesPresentationLogic?
    private var worker: FavoritesWorkLogic
    
    init(presenter: FavoritesPresentationLogic, worker: FavoritesWorkLogic) {
        self.presenter = presenter
        self.worker = worker
    }
}

//MARK: Business Logic Protocol
extension FavoritesInteractor: FavoritesBusinessLogic {
    func fecthAll(request: Favorites.FecthAll.Request) {
        let favorites = MarvelDataProvider.fetchFavoriteCharacters().map { $0.toCharacter() }
        presenter?.presentFetchAll(response: Favorites.FecthAll.Response(characters: favorites))
    }
}
