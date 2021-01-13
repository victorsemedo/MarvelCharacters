//
//  FavoritesViewController.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 13/01/21.
//

import UIKit

protocol FavoritesDisplayLogic: class {
    func displaySomething(viewModel: Favorites.Something.ViewModel)
}

class FavoritesViewController: UIViewController {
    private var interactor: FavoritesBusinessLogic?
    private var router: FavoritesRoutingLogic?
    
    private var customView = CharactersView()
    
    override func loadView() {
        view = customView
    }
    
    // MARK: Architecture Setup
    func setup(interactor: FavoritesBusinessLogic? = nil, router: FavoritesRoutingLogic? = nil) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: Display Logic Protocol
extension FavoritesViewController: FavoritesDisplayLogic {
    func displaySomething(viewModel: Favorites.Something.ViewModel) {
    }
}
