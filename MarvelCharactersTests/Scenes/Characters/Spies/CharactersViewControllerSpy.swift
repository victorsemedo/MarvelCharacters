//
//  CharactersViewControllerSpy.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 19/01/21.
//

@testable import MarvelCharacters
import UIKit

class CharactersViewControllerSpy: UIViewControllerSpy {
    var displayLoadNextPageCalled = false
    var displayErrorCalled = false
    var displayUpdateFavoriteCalled = false
}

extension CharactersViewControllerSpy: CharactersDisplayLogic {
    func displayLoadNextPage(viewModel: Characters.LoadNextPage.ViewModel) {
        displayLoadNextPageCalled = true
    }
    
    func displayError(emptyType: CharactersEmptyType) {
        displayErrorCalled = true

    }
    
    func displayUpdateFavorite(viewModel: Characters.UpdateFavorite.ViewModel) {
        displayUpdateFavoriteCalled = true
    }
    
}
