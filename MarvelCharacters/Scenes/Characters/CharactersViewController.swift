//
//  CharactersViewController.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 09/01/21.
//

import UIKit

protocol CharactersDisplayLogic: class {
    func displayLoadNextPage(viewModel: Characters.LoadNextPage.ViewModel)
    func displayError()
    func displayUpdateFavorite(request: Characters.UpdateFavorite.ViewModel)
}

class CharactersViewController: UIViewController {
    
    private var interactor: CharactersBusinessLogic?
    private var router: CharactersRoutingLogic?
    private var customView = CharactersView()
    
    private var currentPage = 0
    private var isLoading = false
    
    override func loadView() {
        view = customView
        customView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        isLoading = true
        customView.refreshControl.beginRefreshing()
        customView.collectionView.contentOffset = CGPoint.init(x: 0, y: -customView.refreshControl.frame.size.height)            
        let request = Characters.LoadNextPage.Request(page: currentPage, searchName: nil, reset: true)
        interactor?.loadNextPage(request: request)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !isLoading {
            isLoading = true
            interactor?.reloadFavorites(request: Characters.ReloadFavorites.Request())
        }
    }
    
    // MARK: Architecture Setup
    func setup(interactor: CharactersBusinessLogic? = nil, router: CharactersRoutingLogic? = nil) {
        self.interactor = interactor
        self.router = router
    }
    
    func setupView() {
        title = Strings.characters.localizable.uppercased()
    }
}

// MARK: Display Logic Protocol
extension CharactersViewController: CharactersDisplayLogic {
    
    func displayError() {
        
    }
    
    func displayLoadNextPage(viewModel: Characters.LoadNextPage.ViewModel) {
        isLoading = false
        customView.refreshControl.endRefreshing()
        customView.viewModel = CharactersView.ViewModel(cells: viewModel.characters)
    }
    
    func displayUpdateFavorite(request: Characters.UpdateFavorite.ViewModel) {
        
    }
    
}

// MARK: CharactersViewDelegate
extension CharactersViewController: CharactersViewDelegate {
    func didSelectItemAt(_ view: CharactersView, forIndexPath indexPath: IndexPath) {
        interactor?.selectCharacter(request: Characters.SelectCharacter.Request(index: indexPath.row))
        router?.routeToDetails()
    }
    
    func willDisplayLastCell(_ view: CharactersView) {
        if !isLoading {
            isLoading = true
            currentPage = currentPage + 1
            let searchName = (view.searchBar.text?.count ?? 0) > 0 ? view.searchBar.text : nil
            let request = Characters.LoadNextPage.Request(page: currentPage, searchName: searchName, reset: false)
            interactor?.loadNextPage(request: request)
        }
    }
    
    func didUpdateSearchBar(_ view: CharactersView) {
        if !isLoading {
            isLoading = true
            currentPage = 0
            let searchName = (view.searchBar.text?.count ?? 0) > 0 ? view.searchBar.text : nil
            let request = Characters.LoadNextPage.Request(page: currentPage, searchName: searchName, reset: true)
            interactor?.loadNextPage(request: request)
        }
    }
    
    func didUpdateFavorite(_ view: CharactersView, forIndexPath indexPath: IndexPath, withValue value: Bool) {
        let cell = view.collectionView.cellForItem(at: indexPath) as? CharactersViewCell
        let request = Characters.UpdateFavorite.Request(index: indexPath.row, isFavorite: value, image: cell?.imageView.image)
        interactor?.updateFavorite(request: request)
    }
    
    func didPullToRefresh(_ view: CharactersView) {
        view.refreshControl.beginRefreshing()
        currentPage = 0
        let searchName = (view.searchBar.text?.count ?? 0) > 0 ? view.searchBar.text : nil
        let request = Characters.LoadNextPage.Request(page: currentPage, searchName: searchName, reset: true)
        interactor?.loadNextPage(request: request)
    }
    
}


