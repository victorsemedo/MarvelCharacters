//
//  CharactersPresenterSpy.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 19/01/21.
//

@testable import MarvelCharacters

class CharactersPresenterSpy {
    var presentLoadNextPageCalled = false
    var presentUpdateFavoriteCalled = false
    var presentErrorCalled = false
}

extension CharactersPresenterSpy: CharactersPresentationLogic {
    func presentLoadNextPage(response: Characters.LoadNextPage.Response) {
        presentLoadNextPageCalled = true
    }
    
    func presentUpdateFavorite(response: Characters.UpdateFavorite.Response) {
        presentUpdateFavoriteCalled = true
    }
    
    func presentError(error: Error) {
        presentErrorCalled = true
    }
    
}
