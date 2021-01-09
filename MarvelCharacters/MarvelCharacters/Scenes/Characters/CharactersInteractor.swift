//
//  CharactersInteractor.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 09/01/21.
//

import UIKit

protocol CharactersBusinessLogic {
    func doSomething(request: Characters.Something.Request)
}

protocol CharactersDataStore {
}

class CharactersInteractor: CharactersDataStore {
    private var presenter: CharactersPresentationLogic?
    private var worker: CharactersWorkLogic
    
    init(presenter: CharactersPresentationLogic, worker: CharactersWorkLogic) {
        self.presenter = presenter
        self.worker = worker
    }
}

//MARK: Business Logic Protocol
extension CharactersInteractor: CharactersBusinessLogic {
    func doSomething(request: Characters.Something.Request) {
    }
}
