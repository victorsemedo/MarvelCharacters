//
//  FavoritesViewController.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 13/01/21.
//

import UIKit

protocol FavoritesDisplayLogic: class {
    func displayFetchAll(viewModel: Favorites.FecthAll.ViewModel)
}

class FavoritesViewController: UIViewController {
    private var interactor: FavoritesBusinessLogic?
    private var router: FavoritesRoutingLogic?
    
    private var customView = CharactersView()
    
    override func loadView() {
        view = customView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        let request = Favorites.FecthAll.Request()
        interactor?.fecthAll(request: request)
    }
    
    // MARK: Architecture Setup
    func setup(interactor: FavoritesBusinessLogic? = nil, router: FavoritesRoutingLogic? = nil) {
        self.interactor = interactor
        self.router = router
    }
    
    func setupView() {
        title = "FAVORITES"
    }
}

// MARK: Display Logic Protocol
extension FavoritesViewController: FavoritesDisplayLogic {
    func displayFetchAll(viewModel: Favorites.FecthAll.ViewModel) {
        customView.viewModel = CharactersView.ViewModel(cells: viewModel.characters)
    }
}
