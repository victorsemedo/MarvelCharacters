//
//  CharactersPresenter.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 09/01/21.
//

import UIKit

protocol CharactersPresentationLogic {
    func presentLoadNextPage(response: Characters.LoadNextPage.Response)
}

class CharactersPresenter {
    private weak var viewController: CharactersDisplayLogic?
    
    init(viewController: CharactersDisplayLogic) {
        self.viewController = viewController
    }
}

// MARK: Presentation Logic Protocol
extension CharactersPresenter: CharactersPresentationLogic {
    
    func presentLoadNextPage(response: Characters.LoadNextPage.Response) {
        guard let characters = response.data.characters else {
            viewController?.displayError()
            return
        }
        self.viewController?.displayLoadNextPage(viewModel: Characters.LoadNextPage.ViewModel(characters: characters))
    }
}

extension Character: CharactersCellProtocol {
    
    var isFavorite: Bool {
        return false
    }
    
}
