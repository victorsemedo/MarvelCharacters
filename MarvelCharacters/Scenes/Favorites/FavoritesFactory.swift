//
//  FavoritesFactory.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 13/01/21.
//

import UIKit

class FavoritesFactory {
    static func setupFavorites() -> UIViewController {
        let viewController = FavoritesViewController()
        let worker = FavoritesWorker()
        let presenter = FavoritesPresenter(viewController: viewController)
        let interactor = FavoritesInteractor(presenter: presenter, worker: worker)
        let router = FavoritesRouter(viewController: viewController, dataStore: interactor)
        viewController.setup(interactor: interactor, router: router)
        return viewController
    }
}
