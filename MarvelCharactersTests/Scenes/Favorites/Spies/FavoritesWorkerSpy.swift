//
//  FavoritesWorkerSpy.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 19/01/21.
//

@testable import MarvelCharacters
import UIKit

enum FavoritesWorkerSpyResult {
    case success
    case empty
    case error
}

class FavoritesWorkerSpy {
    var saveFavoriteCharacter: Character? = nil
    var deleteFavoriteCharacter: Character? = nil
    var loadFavoriteCharactersId: String? = nil
    
    var saveAndDeleteResult = true
    var loadFavoritesResult = FavoritesWorkerSpyResult.success
}

extension FavoritesWorkerSpy: FavoritesWorkLogic {
    
    func saveFovoriteCharacter(_ character: Character, image: UIImage?, result: @escaping (Result<Bool, DataProviderError>) -> Void) {
        saveFavoriteCharacter = character
        if saveAndDeleteResult {
            result(.success(saveAndDeleteResult))
        } else {
            result(.failure(DataProviderError.save))
        }
    }
    
    func deleteFavoriteCharacter(_ character: Character, result: @escaping (Result<Bool, DataProviderError>) -> Void) {
        deleteFavoriteCharacter = character
        if saveAndDeleteResult {
            result(.success(saveAndDeleteResult))
        } else {
            result(.failure(DataProviderError.delete))
        }
    }
    
    func loadFavoriteCharacters(byName name: String?, result: @escaping (Result<[Character], DataProviderError>) -> Void) {
        loadFavoriteCharactersId = name
        switch loadFavoritesResult {
        case .success:
            result(.success(FavoritesSeeds.fecthAllResponse.characters))
        case .empty:
            result(.success([Character]()))
        case .error:
            result(.failure(DataProviderError.fetch))
        }
    }
    
}
