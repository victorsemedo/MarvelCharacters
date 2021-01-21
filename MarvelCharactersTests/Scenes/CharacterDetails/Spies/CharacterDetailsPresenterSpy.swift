//
//  CharacterDetailsPresenterSpy.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 19/01/21.
//

@testable import MarvelCharacters

class CharacterDetailsPresenterSpy {
    var presentCharacterResponse: CharacterDetails.LoadCharacter.Response? = nil
    var presentComicsAndSeriesResponse: CharacterDetails.LoadComicsSeries.Response? = nil
    var presentUpdateFavoriteResponse: CharacterDetails.UpdateFavorite.Response? = nil
    var presentError: Error? = nil
    var presentComicsAndSeriesError: (Bool, Error)? = nil
}

extension CharacterDetailsPresenterSpy: CharacterDetailsPresentationLogic {
    
    func presentCharacter(response: CharacterDetails.LoadCharacter.Response) {
        presentCharacterResponse = response
    }
    
    func presentComicsAndSeries(response: CharacterDetails.LoadComicsSeries.Response) {
        presentComicsAndSeriesResponse = response
    }
    
    func presentUpdateFavorite(response: CharacterDetails.UpdateFavorite.Response) {
        presentUpdateFavoriteResponse = response
    }
    
    func presentError(error: Error) {
        presentError = error
    }
    
    func presentComicsAndSeriesError(isComics: Bool, error: Error) {
        presentComicsAndSeriesError = (isComics, error)
    }
    
    
}
