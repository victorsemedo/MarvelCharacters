//
//  CharactersPresenterSpy.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 19/01/21.
//

@testable import MarvelCharacters

class CharactersPresenterSpy {
    var presentLoadNextPageResponse: Characters.LoadNextPage.Response? = nil
    var presentUpdateFavoriteResponse: Characters.UpdateFavorite.Response? = nil
    var presentError: Error? = nil
}

extension CharactersPresenterSpy: CharactersPresentationLogic {
    func presentLoadNextPage(response: Characters.LoadNextPage.Response) {
        presentLoadNextPageResponse = nil
    }
    
    func presentUpdateFavorite(response: Characters.UpdateFavorite.Response) {
        presentUpdateFavoriteResponse = nil
    }
    
    func presentError(error: Error) {
        presentError = nil
    }
}
