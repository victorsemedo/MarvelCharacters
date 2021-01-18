//
//  FavoritesViewController.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 13/01/21.
//

import UIKit

protocol FavoritesDisplayLogic: class {
    func displayFetchAll(viewModel: Favorites.FecthAll.ViewModel)
    func displayUpdateFavorite(viewModel: Favorites.UpdateFavorite.ViewModel)

}

final class FavoritesViewController: UIViewController {
    private var interactor: FavoritesBusinessLogic?
    private var router: FavoritesRoutingLogic?
    
    private var customView = CharactersView()
    
    override func loadView() {
        view = customView
        customView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        customView.refreshControl.beginRefreshing()
        interactor?.fecthAll(request: Favorites.FecthAll.Request(filterName: customView.searchBar.text))
    }
    
    // MARK: Architecture Setup
    func setup(interactor: FavoritesBusinessLogic? = nil, router: FavoritesRoutingLogic? = nil) {
        self.interactor = interactor
        self.router = router
    }
    
    func setupView() {
        title = Strings.favorites.localizable.uppercased()
    }
}

// MARK: Display Logic Protocol
extension FavoritesViewController: FavoritesDisplayLogic {
    func displayUpdateFavorite(viewModel: Favorites.UpdateFavorite.ViewModel) {
        if !viewModel.result {
            let indexPath = IndexPath(row: viewModel.index, section: 0)
            if let cell = customView.collectionView.cellForItem(at: indexPath) as? CharactersViewCell {
                cell.favoriteView.toogleFill()
            }
        }
    }
    
    func displayFetchAll(viewModel: Favorites.FecthAll.ViewModel) {
        customView.refreshControl.endRefreshing()
        customView.viewModel = CharactersView.ViewModel(cells: viewModel.characters, emptyType: viewModel.emptyType)
    }
}

// MARK: CharactersViewDelegate
extension FavoritesViewController: CharactersViewDelegate {
    
    func didSelectItemAt(_ view: CharactersView, forIndexPath indexPath: IndexPath) {
        interactor?.selectCharacter(request: Favorites.SelectCharacter.Request(index: indexPath.row))
        router?.routeToDetails()
    }
    
    func didUpdateSearchBar(_ view: CharactersView) {

    }
    
    func didUpdateFavorite(_ view: CharactersView, forIndexPath indexPath: IndexPath, withValue value: Bool) {
        let cell = view.collectionView.cellForItem(at: indexPath) as? CharactersViewCell
        let request = Favorites.UpdateFavorite.Request(index: indexPath.row, isFavorite: value, image: cell?.imageView.image)
        interactor?.updateFavorite(request: request)
        interactor?.fecthAll(request: Favorites.FecthAll.Request(filterName: customView.searchBar.text))
    }
    
    func didPullToRefresh(_ view: CharactersView) {
        view.refreshControl.beginRefreshing()
        interactor?.fecthAll(request: Favorites.FecthAll.Request(filterName: customView.searchBar.text))
    }
}

