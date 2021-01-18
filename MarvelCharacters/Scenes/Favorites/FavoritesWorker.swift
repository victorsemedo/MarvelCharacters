//
//  FavoritesWorker.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 13/01/21.
//

import UIKit

protocol FavoritesWorkLogic: class {
    func saveFovoriteCharacter(_ character: Character, image: UIImage?, result: @escaping (Result<Bool, DataProviderError>) -> Void)
    
    func deleteFavoriteCharacter(_ character: Character, result: @escaping (Result<Bool, DataProviderError>) -> Void)
    
    func loadFavoriteCharacters(byName name: String?, result: @escaping (Result<[Character], DataProviderError>) -> Void)
}

// MARK: Work Logic Protocol
class FavoritesWorker: FavoritesWorkLogic {
    
    func saveFovoriteCharacter(_ character: Character, image: UIImage?, result: @escaping (Result<Bool, DataProviderError>) -> Void) {
        let data = image?.jpegData(compressionQuality: 1.0)
        if let error = MarvelDataProvider.saveFavoriteCharacter(character, image: data) {
            result(.failure(error))
        } else {
            result(.success(true))
        }
    }
    
    func deleteFavoriteCharacter(_ character: Character, result: @escaping (Result<Bool, DataProviderError>) -> Void) {
        if let error = MarvelDataProvider.deleteFavoriteCharacter(withId: character.id) {
            result(.failure(error))
        } else {
            result(.success(true))
        }
    }
    
    func loadFavoriteCharacters(byName name: String?, result: @escaping (Result<[Character], DataProviderError>) -> Void) {
        do {
            let characters = try MarvelDataProvider.fetchFavoriteCharacters(byName: name)
            result(.success(characters.map {$0.toCharacter()}))
        } catch {
            result(.failure(DataProviderError.fetch))
        }
    }
}
