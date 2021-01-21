//
//  CharacterDetailsSeeds.swift
//  MarvelCharactersTests
//
//  Created by Victor Tavares on 20/01/21.
//

import Foundation
@testable import MarvelCharacters

struct CharacterDetailsSeeds {
    
    static var loadCharacterResponse: CharacterDetails.LoadCharacter.Response {
        let charactersResponse : MarvelFetchListResponse<Character>? = MockReader.decodeOject(fromFile: MockFile.characters)
        let character = charactersResponse?.data.results[0]
        return CharacterDetails.LoadCharacter.Response(character: character)
    }

    static var loadCharacterViewModel: CharacterDetails.LoadCharacter.ViewModel {
        let charactersResponse : MarvelFetchListResponse<Character>? = MockReader.decodeOject(fromFile: MockFile.characters)
        let character = charactersResponse?.data.results[0]
        return CharacterDetails.LoadCharacter.ViewModel.init(name: character?.name,
                                                             description: character?.description,
                                                             imageUrl: character?.imageUrl,
                                                             image: character?.image,
                                                             isFavorite: true)
    }
    
    static var loadComicsSeriesResponse: CharacterDetails.LoadComicsSeries.Response {
        let comicsResponse : MarvelFetchListResponse<Comic>? = MockReader.decodeOject(fromFile: MockFile.comics)
        let seriesResponse : MarvelFetchListResponse<Serie>? = MockReader.decodeOject(fromFile: MockFile.series)

        let comics = comicsResponse?.data.results ?? [Comic]()
        let series = seriesResponse?.data.results ?? [Serie]()
        return CharacterDetails.LoadComicsSeries.Response(comics: comics, series: series)
    }

    static var loadComicsSeriesViewModel: CharacterDetails.LoadComicsSeries.ViewModel {
        return CharacterDetails.LoadComicsSeries.ViewModel(comics: loadComicsSeriesResponse.comics,
                                                          series: loadComicsSeriesResponse.series)
    }
    
    static var updateFavoriteRequest: CharacterDetails.UpdateFavorite.Request {
        return CharacterDetails.UpdateFavorite.Request(isFavorite: true, image: nil)
    }
    
    static var updateFavoriteResponse: CharacterDetails.UpdateFavorite.Response {
        return CharacterDetails.UpdateFavorite.Response(result: true)
    }
    
    static var updateFavoriteViewModel: CharacterDetails.UpdateFavorite.ViewModel {
        return CharacterDetails.UpdateFavorite.ViewModel(result: true)
    }
}
