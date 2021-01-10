//
//  CharactersFactory.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 09/01/21.
//

import UIKit

class CharactersFactory {
    static func setupCharacters() -> UIViewController {
        let viewController = CharactersViewController()
        let worker = CharactersWorker()
        let presenter = CharactersPresenter(viewController: viewController)
        let interactor = CharactersInteractor(presenter: presenter, worker: worker)
        let router = CharactersRouter(viewController: viewController, dataStore: interactor)
        viewController.setup(interactor: interactor, router: router)
        return viewController
    }
}
