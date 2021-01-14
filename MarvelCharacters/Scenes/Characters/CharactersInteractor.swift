//
//  CharactersInteractor.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 09/01/21.
//

import UIKit

protocol CharactersBusinessLogic {
    func loadNextPage(request: Characters.LoadNextPage.Request)
    func updateFavorite(request: Characters.UpdateFavorite.Request)
}

protocol CharactersDataStore {
    var characters: [Character] { get }
}

class CharactersInteractor: CharactersDataStore {
   
    private var presenter: CharactersPresentationLogic?
    private var worker: CharactersWorkLogic
    
    private var currentPage =  0
    var characters = [Character]()
    
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
                self.updateCharacters(withResponse: response.data.characters, reset: request.reset)
                let response = Characters.LoadNextPage.Response(data: CharactersResponse(characters: self.characters))
                self.presenter?.presentLoadNextPage(response: response)
            case .failure(let error):
                break
            }
        }
    }
    
    func updateFavorite(request: Characters.UpdateFavorite.Request) {
        let character = characters[request.index]
        if request.isFavorite {
            worker.saveFovoriteCharacter(character)
        } else {
            worker.deleteFavoriteCharacter(character)
        }
    }
    
}

private extension CharactersInteractor {
    
    func updateCharacters(withResponse response: [Character]?, reset: Bool) {
        guard let response = response else { return }
        
        if reset {
            characters = response
        } else {
            characters.append(contentsOf: characters)
        }
    }
}
