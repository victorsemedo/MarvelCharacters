//
//  CharactersRouter.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 09/01/21.
//

import UIKit

protocol CharactersRoutingLogic {
    func routeToDetails()
}

protocol CharactersDataPassing {
    var dataStore: CharactersDataStore? { get }
}

final class CharactersRouter: CharactersDataPassing {
    private weak var viewController: UIViewController?
    var dataStore: CharactersDataStore?
    
    init(viewController: UIViewController, dataStore: CharactersDataStore? = nil) {
        self.viewController = viewController
        self.dataStore = dataStore
    }
}

// MARK: Routing Logic Protocol
extension CharactersRouter: CharactersRoutingLogic {
    func routeToDetails() {
        if let character = dataStore?.selectedCharacter {
            let details = CharacterDetailsFactory.setupCharacterDetails(character)
            viewController?.navigationController?.pushViewController(details, animated: true)
        }
    }
}

