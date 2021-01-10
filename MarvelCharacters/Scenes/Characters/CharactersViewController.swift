//
//  CharactersViewController.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 09/01/21.
//

import UIKit

protocol CharactersDisplayLogic: class {
    func displaySomething(viewModel: Characters.Something.ViewModel)
}

class CharactersViewController: UIViewController {
    private var interactor: CharactersBusinessLogic?
    private var router: CharactersRoutingLogic?
    
    private var customView = CharactersView()
    
    override func loadView() {
        view = customView
    }
    
    // MARK: Architecture Setup
    func setup(interactor: CharactersBusinessLogic? = nil, router: CharactersRoutingLogic? = nil) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: Display Logic Protocol
extension CharactersViewController: CharactersDisplayLogic {
    func displaySomething(viewModel: Characters.Something.ViewModel) {
    }
}
