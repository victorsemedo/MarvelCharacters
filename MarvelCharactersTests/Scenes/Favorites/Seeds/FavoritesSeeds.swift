//
//  FavoritesSeeds.swift
//  MarvelCharactersTests
//
//  Created by Victor Tavares on 20/01/21.
//

import UIKit
@testable import MarvelCharacters

struct FavoritesSeeds {
    
    static var fecthAllResponse: Favorites.FecthAll.Response {
        let charactersResponse : MarvelFetchListResponse<Character>? = MockReader.decodeOject(fromFile: MockFile.characters)
        let characters = charactersResponse?.data.results ?? [Character]()
        return Favorites.FecthAll.Response(characters: characters)
    }
    
    static var fecthAllEmpty: Favorites.FecthAll.Response {
        return Favorites.FecthAll.Response(characters: [Character]())
    }
    
    static var fecthAllViewModel: Favorites.FecthAll.ViewModel {
        let charactersResponse : MarvelFetchListResponse<Character>? = MockReader.decodeOject(fromFile: MockFile.characters)
        let characters = charactersResponse?.data.results ?? [Character]()
        return Favorites.FecthAll.ViewModel(characters: characters, emptyType: .none)
    }
    
    static var fecthAllEmptyViewModel: Favorites.FecthAll.ViewModel {
        let characters = [Character]()
        return Favorites.FecthAll.ViewModel(characters: characters, emptyType: .emptyFavorites)
    }
    
    static var updateResponse: Favorites.UpdateFavorite.Response {
        return Favorites.UpdateFavorite.Response(result: true, index: 0)
    }
    
    static var updateResponseError: Favorites.UpdateFavorite.Response {
        return Favorites.UpdateFavorite.Response(result: false, index: 0)
    }
    
    static var updateViewModel: Favorites.UpdateFavorite.ViewModel {
        return Favorites.UpdateFavorite.ViewModel(result: true, index: 0)
    }
    
    static var updateViewModelError: Favorites.UpdateFavorite.ViewModel {
        return Favorites.UpdateFavorite.ViewModel(result: false, index: 0)
    }
    
}
