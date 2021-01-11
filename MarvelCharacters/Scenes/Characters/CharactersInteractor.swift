//
//  CharactersInteractor.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 09/01/21.
//

import UIKit

protocol CharactersBusinessLogic {
    func loadNextPage(request: Characters.LoadNextPage.Request)
}

protocol CharactersDataStore {
    
}

class CharactersInteractor: CharactersDataStore {
    private var presenter: CharactersPresentationLogic?
    private var worker: CharactersWorkLogic
    
    private var currentPage =  0
    private var characters = [Characters]()
    
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
                self.presenter?.presentLoadNextPage(response: response)
            case .failure(let error):
                break
            }
        }
    }
}
