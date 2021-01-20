//
//  CharactersSeeds.swift
//  MarvelCharactersTests
//
//  Created by Victor Tavares on 20/01/21.
//

@testable import MarvelCharacters

struct CharactersSeeds {

    static let loadNextPageEmpty = Characters.LoadNextPage.Response.init(characters: [Character]())
    
    static var loadNextPage: Characters.LoadNextPage.Response {
        let charactersResponse : MarvelFetchListResponse<Character>? = MockReader.decodeOject(fromFile: MockFile.characters)
        let characters =  charactersResponse?.data.results ?? [Character]()
        return Characters.LoadNextPage.Response(characters: characters)
    }
    
    static var loadNextPageViewModel: Characters.LoadNextPage.ViewModel {
        let charactersResponse : MarvelFetchListResponse<Character>? = MockReader.decodeOject(fromFile: MockFile.characters)
        let characters =  charactersResponse?.data.results ?? [Character]()
        return Characters.LoadNextPage.ViewModel(characters: characters, emptyType: .none)
    }
    
    static var loadNextPageViewModelInternet: Characters.LoadNextPage.ViewModel {
        return Characters.LoadNextPage.ViewModel(characters: [Character](), emptyType: .internetConnection)
    }
    
    static var loadNextPageViewModelError: Characters.LoadNextPage.ViewModel {
        return Characters.LoadNextPage.ViewModel(characters: [Character](), emptyType: .apiError)
    }
  
}
