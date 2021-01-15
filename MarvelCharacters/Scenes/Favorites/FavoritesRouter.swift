//
//  FavoritesRouter.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 13/01/21.
//

import UIKit

protocol FavoritesRoutingLogic {
    func routeToDetails()
}

protocol FavoritesDataPassing {
    var dataStore: FavoritesDataStore? { get }
}

class FavoritesRouter: FavoritesDataPassing {
    private weak var viewController: UIViewController?
    var dataStore: FavoritesDataStore?
    
    init(viewController: UIViewController, dataStore: FavoritesDataStore? = nil) {
        self.viewController = viewController
        self.dataStore = dataStore
    }
}

// MARK: Routing Logic Protocol
extension FavoritesRouter: FavoritesRoutingLogic {
    func routeToDetails() {
        if let character = dataStore?.selectedCharacter {
            let details = CharacterDetailsFactory.setupCharacterDetails(character)
            viewController?.navigationController?.pushViewController(details, animated: true)
        }
    }
}

