//
//  CharactersViewController.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 09/01/21.
//

import UIKit

protocol CharactersDisplayLogic: class {
    func displayLoadNextPage(viewModel: Characters.LoadNextPage.ViewModel)
}

class CharactersViewController: UIViewController {
    
    private var interactor: CharactersBusinessLogic?
    private var router: CharactersRoutingLogic?

    private var customView = CharactersView()
    private var viewModel: Characters.LoadNextPage.ViewModel?
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        let request = Characters.LoadNextPage.Request(page: 0, searchName: nil)
        interactor?.loadNextPage(request: request)
    }
    
    // MARK: Architecture Setup
    func setup(interactor: CharactersBusinessLogic? = nil, router: CharactersRoutingLogic? = nil) {
        self.interactor = interactor
        self.router = router
    }
    
    func setupView() {
        title = "Characters"
    }
}

// MARK: Display Logic Protocol
extension CharactersViewController: CharactersDisplayLogic {
    
    func displayLoadNextPage(viewModel: Characters.LoadNextPage.ViewModel) {
        
    }

}
