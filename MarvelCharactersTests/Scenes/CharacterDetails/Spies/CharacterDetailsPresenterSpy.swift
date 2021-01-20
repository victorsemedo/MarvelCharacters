//
//  CharacterDetailsPresenterSpy.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 19/01/21.
//

@testable import MarvelCharacters

class CharacterDetailsPresenterSpy {
    var presentCharacterCalled = false
    var presentComicsAndSeriesCalled = false
    var presentUpdateFavoriteCalled = false
    var presentErrorCalled = false

}

extension CharacterDetailsPresenterSpy: CharacterDetailsPresentationLogic {
    
    func presentCharacter(response: CharacterDetails.LoadCharacter.Response) {
        presentCharacterCalled = true
    }
    
    func presentComicsAndSeries(response: CharacterDetails.LoadComicsSeries.Response) {
        presentComicsAndSeriesCalled = true
    }
    
    func presentUpdateFavorite(response: CharacterDetails.UpdateFavorite.Response) {
        presentUpdateFavoriteCalled = true
    }
    
    func presentError(error: Error) {
        presentErrorCalled = true
    }
}
