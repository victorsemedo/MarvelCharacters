//
//  CharactersRouter.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 09/01/21.
//

import UIKit

protocol CharactersRoutingLogic {
    func routeToSomewhere()
}

protocol CharactersDataPassing {
    var dataStore: CharactersDataStore? { get }
}

class CharactersRouter: CharactersDataPassing {
    private weak var viewController: UIViewController?
    var dataStore: CharactersDataStore?
    
    init(viewController: UIViewController, dataStore: CharactersDataStore? = nil) {
        self.viewController = viewController
        self.dataStore = dataStore
    }
}

// MARK: Routing Logic Protocol
extension CharactersRouter: CharactersRoutingLogic {
    func routeToSomewhere() {
    }
}

