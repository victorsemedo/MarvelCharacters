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

final class FavoritesInteractor: FavoritesDataStore {
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
        worker.loadFavoriteCharacters(byName: request.filterName) { (result) in
            switch result {
            case .success(let characters):
                self.favoriteCharacters = characters
                self.presenter?.presentFetchAll(response: Favorites.FecthAll.Response(characters: self.favoriteCharacters))
            case .failure(let error):
                self.presenter?.presentError(error: error)
            }
        }
    }
    
    func selectCharacter(request: Favorites.SelectCharacter.Request) {
        selectedCharacter = favoriteCharacters[request.index]
    }
    
    func updateFavorite(request: Favorites.UpdateFavorite.Request) {
        let character = favoriteCharacters[request.index]
        if request.isFavorite {
            worker.saveFovoriteCharacter(character, image: request.image) { (result) in
                self.validateUpdateFavoriteResult(index: request.index, result: result)
            }
        } else {
            worker.deleteFavoriteCharacter(character) { (result) in
                self.validateUpdateFavoriteResult(index: request.index, result: result)
            }
        }
    }
}

private extension FavoritesInteractor {
    
    func validateUpdateFavoriteResult(index: Int, result: Result<Bool, DataProviderError>) {
        switch result {
        case .success(let value):
            let response = Favorites.UpdateFavorite.Response(result: value, index: index)
            self.presenter?.presentUpdateFavorite(response: response)
        case .failure(let error):
            self.presenter?.presentError(error: error)
        }
    }
}
