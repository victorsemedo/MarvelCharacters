//
//  CharactersPresenter.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 09/01/21.
//

import UIKit

protocol CharactersPresentationLogic {
    func presentLoadNextPage(response: Characters.LoadNextPage.Response)
    func presentUpdateFavorite(request: Characters.UpdateFavorite.Response)
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
        self.viewController?.displayLoadNextPage(viewModel: Characters.LoadNextPage.ViewModel(characters: response.characters))
    }
    
    func presentUpdateFavorite(request: Characters.UpdateFavorite.Response) {

    }
}
