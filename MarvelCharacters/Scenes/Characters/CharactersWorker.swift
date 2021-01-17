//
//  CharactersWorker.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 09/01/21.
//

import UIKit

protocol CharactersWorkLogic: FavoritesWorkLogic {
    
    func loadNextPage(request: Characters.LoadNextPage.Request, result: @escaping (Result<Characters.LoadNextPage.Response, APIError>) -> Void)
    
}

// MARK: Work Logic Protocol
class CharactersWorker: FavoritesWorker, CharactersWorkLogic {

    func loadNextPage(request: Characters.LoadNextPage.Request, result: @escaping (Result<Characters.LoadNextPage.Response, APIError>) -> Void) {
        APIProvider.makeRequest(MarvelAPI.characters(request.searchName, request.page*20)) { (providerResult: Result<MarvelFetchListResponse<Character>, APIError>) in
            switch providerResult {
            case .success(let response):
                let response = Characters.LoadNextPage.Response(characters: response.data.results)
                result(.success(response))
            case.failure(let error):
                result(.failure(error))
            }
        }
    }
}
