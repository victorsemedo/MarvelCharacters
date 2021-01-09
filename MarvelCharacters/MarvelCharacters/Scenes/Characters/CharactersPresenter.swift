//
//  CharactersPresenter.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 09/01/21.
//

import UIKit

protocol CharactersPresentationLogic {
    func presentSomething(response: Characters.Something.Response)
}

class CharactersPresenter {
    private weak var viewController: CharactersDisplayLogic?
    
    init(viewController: CharactersDisplayLogic) {
        self.viewController = viewController
    }
}

// MARK: Presentation Logic Protocol
extension CharactersPresenter: CharactersPresentationLogic {
    func presentSomething(response: Characters.Something.Response) {
    }
}
