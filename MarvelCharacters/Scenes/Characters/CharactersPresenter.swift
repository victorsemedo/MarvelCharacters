//
//  CharactersPresenter.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 09/01/21.
//

import UIKit

protocol CharactersPresentationLogic {
    func presentLoadNextPage(response: Characters.LoadNextPage.Response)
    func presentUpdateFavorite(response: Characters.UpdateFavorite.Response)
    func presentError(error: Error)
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
        let emptyType: CharactersEmptyType? = response.characters.count > 0 ? nil : .apiError
        self.viewController?.displayLoadNextPage(viewModel: Characters.LoadNextPage.ViewModel(characters: response.characters, emptyType: emptyType))
    }
    
    func presentError(error: Error) {
        var emptyType: CharactersEmptyType = .apiError
        
        if let error = error as? APIError {
            switch error {
            case .noConnection:
                emptyType = .internetConnection
            default:
                break
            }
        }
        viewController?.displayError(emptyType: emptyType)
    }
    
    func presentUpdateFavorite(response: Characters.UpdateFavorite.Response) {
        let viewModel = Characters.UpdateFavorite.ViewModel(result: response.result, index: response.index)
        viewController?.displayUpdateFavorite(viewModel: viewModel)
    }
}
