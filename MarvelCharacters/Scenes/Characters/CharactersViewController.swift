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
}

class CharactersViewController: UIViewController {
    
    private var interactor: CharactersBusinessLogic?
    private var router: CharactersRoutingLogic?
    private var customView = CharactersView()
    private var viewModel: Characters.LoadNextPage.ViewModel?
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
        let request = Characters.LoadNextPage.Request(page: currentPage, searchName: nil, reset: true)
        interactor?.loadNextPage(request: request)
    }
    
    // MARK: Architecture Setup
    func setup(interactor: CharactersBusinessLogic? = nil, router: CharactersRoutingLogic? = nil) {
        self.interactor = interactor
        self.router = router
    }
    
    func setupView() {
        title = "Characters"
        navigationController?.navigationBar.tintColor = .redLight
    }
}

// MARK: Display Logic Protocol
extension CharactersViewController: CharactersDisplayLogic {
    
    func displayError() {
        
    }
    
    func displayLoadNextPage(viewModel: Characters.LoadNextPage.ViewModel) {
        isLoading = false
        customView.viewModel = CharactersView.ViewModel(cells: viewModel.characters)
    }

}

// MARK: CharactersViewDelegate
extension CharactersViewController: CharactersViewDelegate {
    
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
    
}
