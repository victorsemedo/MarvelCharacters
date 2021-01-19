//
//  CharactersInteractor.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 09/01/21.
//

import UIKit

protocol CharactersBusinessLogic {
    var selectedCharacterIndex: Int? {get set}
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
    private var hasSavedCharacters = false
    var selectedCharacterIndex: Int? = nil

    init(presenter: CharactersPresentationLogic, worker: CharactersWorkLogic) {
        self.presenter = presenter
        self.worker = worker
    }
}

//MARK: Business Logic Protocol
extension CharactersInteractor: CharactersBusinessLogic {

    func loadNextPage(request: Characters.LoadNextPage.Request) {
        var charactersResponse = [Character]()
        worker.loadNextPage(request: request) { (result) in
            switch result {
            case .success(let response):
                charactersResponse = response.characters
                self.getFavoritesIds { (idsResult) in
                    switch idsResult {
                    case .success(let favorites):
                        self.updateCharacters(withResponse: charactersResponse, favorites: favorites, reset: request.reset)
                        let response = Characters.LoadNextPage.Response(characters: self.characters)
                        self.presenter?.presentLoadNextPage(response: response)
                    case .failure(let error):
                        self.presenter?.presentError(error: error)
                    }
                }
                
            case .failure(let error):
                self.presenter?.presentError(error: error)
            }
        }
    }
    
    func reloadFavorites(request: Characters.ReloadFavorites.Request) {
        self.getFavoritesIds { (result) in
            switch result {
            case .success(let favorites):
                self.updateCharacters(withResponse: self.characters, favorites: favorites, reset: true)
                let response = Characters.LoadNextPage.Response(characters: self.characters)
                self.presenter?.presentLoadNextPage(response: response)
            case .failure(let error):
                self.presenter?.presentError(error: error)
            }
        }
    }
    
    func updateFavorite(request: Characters.UpdateFavorite.Request) {
        characters[request.index].isFavorite = request.isFavorite
        let character = characters[request.index]
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
    
    func selectCharacter(request: Characters.SelectCharacter.Request) {
        selectedCharacter = characters[request.index]
    }
}

private extension CharactersInteractor {
    
    func validateUpdateFavoriteResult(index: Int, result: Result<Bool, DataProviderError>) {
        switch result {
        case .success(let value):
            let response = Characters.UpdateFavorite.Response(result: value, index: index)
            self.presenter?.presentUpdateFavorite(response: response)
        case .failure(let error):
            self.presenter?.presentError(error: error)
        }
    }
    
    func getFavoritesIds(completion: @escaping (Result<[Int], DataProviderError>) -> Void) {
        worker.loadFavoriteCharacters(byName: nil) { (result) in
            switch result {
            case .success(let favorites):
                completion(.success(favorites.map { $0.id }))
            case .failure(let error):
                completion(.failure(error))
            }
        }
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
        saveFirstCharacters()
    }
    
    func saveFirstCharacters() {
        if characters.count > 0 && !hasSavedCharacters {
            let widgetContent = CharactersWidgetContent(characters: Array(characters.prefix(3)))
            
            let archiveURL = AppGroup.characters.filePath(.firstCharacters)
            if let dataToSave = try? JSONEncoder().encode(widgetContent) {
                do {
                    try dataToSave.write(to: archiveURL)
                    hasSavedCharacters =  true
                } catch {
                    print("Error: Can't write first characters")
                    return
                }
            }
        }
    }
}
