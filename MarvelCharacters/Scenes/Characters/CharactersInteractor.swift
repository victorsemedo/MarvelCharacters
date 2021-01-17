//
//  CharactersInteractor.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 09/01/21.
//

import UIKit

protocol CharactersBusinessLogic {
    func loadNextPage(request: Characters.LoadNextPage.Request)
    func reloadFavorites(request: Characters.ReloadFavorites.Request)
    func updateFavorite(request: Characters.UpdateFavorite.Request)
    func selectCharacter(request: Characters.SelectCharacter.Request)
}

protocol CharactersDataStore {
    var selectedCharacter: Character? { get }
}

class CharactersInteractor: CharactersDataStore {
    private var presenter: CharactersPresentationLogic?
    private var worker: CharactersWorkLogic
    
    var selectedCharacter: Character?
    
    private var currentPage =  0
    private var characters = [Character]()
    
    init(presenter: CharactersPresentationLogic, worker: CharactersWorkLogic) {
        self.presenter = presenter
        self.worker = worker
    }
}

//MARK: Business Logic Protocol
extension CharactersInteractor: CharactersBusinessLogic {
    
    func loadNextPage(request: Characters.LoadNextPage.Request) {
        worker.loadNextPage(request: request) { (result) in
            switch result {
            case .success(let response):
                let favorites = self.getFavoritesIds()
                self.updateCharacters(withResponse: response.characters, favorites: favorites, reset: request.reset)
                let response = Characters.LoadNextPage.Response(characters: self.characters, favorites: favorites)
                self.presenter?.presentLoadNextPage(response: response)
            case .failure(let error):
                break
            }
        }
    }
    
    func reloadFavorites(request: Characters.ReloadFavorites.Request) {
        let favorites = self.getFavoritesIds()
        self.updateCharacters(withResponse: characters, favorites: favorites, reset: true)
        let response = Characters.LoadNextPage.Response(characters: self.characters, favorites: favorites)
        self.presenter?.presentLoadNextPage(response: response)
    }
    
    func updateFavorite(request: Characters.UpdateFavorite.Request) {
        characters[request.index].isFavorite = request.isFavorite
        let character = characters[request.index]
        if request.isFavorite {
            worker.saveFovoriteCharacter(character, image: request.image)
        } else {
            worker.deleteFavoriteCharacter(character)
        }
    }
    
    func selectCharacter(request: Characters.SelectCharacter.Request) {
        selectedCharacter = characters[request.index]
    }
}

private extension CharactersInteractor {
    
    func getFavoritesIds() -> [Int] {
        let favorites = worker.loadFavoriteCharacters()
        return favorites.map { $0.id }
    }
    
    func updateCharacters(withResponse response: [Character]?, favorites: [Int]?, reset: Bool) {
        guard var response = response else { return }
        
        if let favorites = favorites {
            for index in response.indices {
                response[index].isFavorite = favorites.contains(response[index].id)
            }
        }
        
        if reset {
            characters = response
        } else {
            characters.append(contentsOf: response)
        }
    }
}
