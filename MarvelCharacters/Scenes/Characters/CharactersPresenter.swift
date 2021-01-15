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
        guard let characters = response.data.characters else {
            viewController?.displayError()
            return
        }
        let charactersViewModel: [CharactersCellProtocol] = characters.map {
            let cellData = CharacterCellData(character: $0)
            cellData.isFavorite = response.favorites?.contains($0.id) ?? false
            return cellData
        }
        self.viewController?.displayLoadNextPage(viewModel: Characters.LoadNextPage.ViewModel(characters: charactersViewModel))
    }
    
    func presentUpdateFavorite(request: Characters.UpdateFavorite.Response) {

    }
}
