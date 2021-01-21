//
//  CharacterDetailsWorker.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 14/01/21.
//

import UIKit


protocol CharacterDetailsWorkLogic: FavoritesWorkLogic {
    
    func fetchComics(byId id: Int, result: @escaping (Result<[Comic], APIError>) -> Void)
    
    func fetchSeries(byId id: Int, result: @escaping (Result<[Serie], APIError>) -> Void)
    
}

// MARK: Work Logic Protocol
final class CharacterDetailsWorker: FavoritesWorker, CharacterDetailsWorkLogic {
    
    func fetchComics(byId id: Int, result: @escaping (Result<[Comic], APIError>) -> Void) {
        APIProvider.makeRequest(MarvelAPI.comics(String(id))) { (providerResult: Result<MarvelFetchListResponse<Comic>, APIError>) in
            switch providerResult {
            case .success(let response):
                result(.success(response.data.results))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
    
    func fetchSeries(byId id: Int, result: @escaping (Result<[Serie], APIError>) -> Void) {
        APIProvider.makeRequest(MarvelAPI.series(String(id))) { (providerResult: Result<MarvelFetchListResponse<Serie>, APIError>) in
            switch providerResult {
            case .success(let response):
                result(.success(response.data.results))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
}
