//
//  CharacterDetailsInteractorSpy.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 19/01/21.
//

@testable import MarvelCharacters

class CharacterDetailsInteractorSpy: CharacterDetailsDataStore {
    var loadCharacterCalled = false
    var loadComicsSeriesCalled = false
    var updateFavoriteCalled = false
    
    var character: Character?
}

extension CharacterDetailsInteractorSpy: CharacterDetailsBusinessLogic {
    
    func loadCharacter(request: CharacterDetails.LoadCharacter.Request) {
        loadCharacterCalled = true
    }
    
    func loadComicsSeries(request: CharacterDetails.LoadComicsSeries.Request) {
        loadComicsSeriesCalled = true
    }
    
    func updateFavorite(request: CharacterDetails.UpdateFavorite.Request) {
        updateFavoriteCalled = true
    }
}
