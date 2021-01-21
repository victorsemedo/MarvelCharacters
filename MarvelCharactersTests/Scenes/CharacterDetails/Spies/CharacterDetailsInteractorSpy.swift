//
//  CharacterDetailsInteractorSpy.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 19/01/21.
//

@testable import MarvelCharacters

class CharacterDetailsInteractorSpy: CharacterDetailsDataStore {
    var loadCharacterRequest: CharacterDetails.LoadCharacter.Request? = nil
    var loadComicsSeriesRequest: CharacterDetails.LoadComicsSeries.Request? = nil
    var updateFavoriteRequest: CharacterDetails.UpdateFavorite.Request? = nil
    
    var character: Character?
}

extension CharacterDetailsInteractorSpy: CharacterDetailsBusinessLogic {
    
    func loadCharacter(request: CharacterDetails.LoadCharacter.Request) {
        loadCharacterRequest = request
    }
    
    func loadComicsSeries(request: CharacterDetails.LoadComicsSeries.Request) {
        loadComicsSeriesRequest = request
    }
    
    func updateFavorite(request: CharacterDetails.UpdateFavorite.Request) {
        updateFavoriteRequest = request
    }
}
