//
//  FavoritesInteractor.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 13/01/21.
//

import UIKit

protocol FavoritesBusinessLogic {
    func fecthAll(request: Favorites.FecthAll.Request)
    func selectCharacter(request: Favorites.SelectCharacter.Request)
    func updateFavorite(request: Favorites.UpdateFavorite.Request)
}

protocol FavoritesDataStore {
    var selectedCharacter: Character? { get }
}

class FavoritesInteractor: FavoritesDataStore {
    private var presenter: FavoritesPresentationLogic?
    private var worker: FavoritesWorkLogic
    
    var selectedCharacter: Character?
    private var favoriteCharacters = [Character]()

    init(presenter: FavoritesPresentationLogic, worker: FavoritesWorkLogic) {
        self.presenter = presenter
        self.worker = worker
    }
}

//MARK: Business Logic Protocol
extension FavoritesInteractor: FavoritesBusinessLogic {
    func fecthAll(request: Favorites.FecthAll.Request) {
        favoriteCharacters = worker.loadFavoriteCharacters()
        presenter?.presentFetchAll(response: Favorites.FecthAll.Response(characters: favoriteCharacters))
    }
    
    func selectCharacter(request: Favorites.SelectCharacter.Request) {
        selectedCharacter = favoriteCharacters[request.index]
    }
    
    func updateFavorite(request: Favorites.UpdateFavorite.Request) {
        let character = favoriteCharacters[request.index]
        if request.isFavorite {
            worker.saveFovoriteCharacter(character, image: request.image)
        } else {
            worker.deleteFavoriteCharacter(character)
        }
    }
}
