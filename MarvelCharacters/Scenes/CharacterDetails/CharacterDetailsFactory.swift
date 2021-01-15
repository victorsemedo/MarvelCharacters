//
//  CharacterDetailsFactory.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 14/01/21.
//

import UIKit

class CharacterDetailsFactory {
    static func setupCharacterDetails(_ character:  Character) -> UIViewController {
        let viewController = CharacterDetailsViewController()
        let worker = CharacterDetailsWorker()
        let presenter = CharacterDetailsPresenter(viewController: viewController)
        let interactor = CharacterDetailsInteractor(presenter: presenter, worker: worker)
        interactor.character = character
        let router = CharacterDetailsRouter(viewController: viewController, dataStore: interactor)
        viewController.setup(interactor: interactor, router: router)
        return viewController
    }
}
