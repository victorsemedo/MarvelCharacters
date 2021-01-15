//
//  CharacterDetailsInteractor.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 14/01/21.
//

import UIKit

protocol CharacterDetailsBusinessLogic {
    func loadData(request: CharacterDetails.LoadData.Request)
}

protocol CharacterDetailsDataStore {
    var character: Character? { get }
}

class CharacterDetailsInteractor: CharacterDetailsDataStore {
    
    var character: Character?
    
    private var presenter: CharacterDetailsPresentationLogic?
    private var worker: CharacterDetailsWorkLogic
    
    init(presenter: CharacterDetailsPresentationLogic, worker: CharacterDetailsWorkLogic) {
        self.presenter = presenter
        self.worker = worker
    }
}

//MARK: Business Logic Protocol
extension CharacterDetailsInteractor: CharacterDetailsBusinessLogic {
    func loadData(request: CharacterDetails.LoadData.Request) {
        presenter?.presentData(response: CharacterDetails.LoadData.Response(character: character))
    }
}
