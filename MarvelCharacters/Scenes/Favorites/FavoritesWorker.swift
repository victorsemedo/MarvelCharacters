//
//  FavoritesWorker.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 13/01/21.
//

import UIKit

protocol FavoritesWorkLogic: class {
    func saveFovoriteCharacter(_ character: Character, image: UIImage?)
    
    func deleteFavoriteCharacter(_ character: Character)
    
    func loadFavoriteCharacters() -> [Character]
}

// MARK: Work Logic Protocol
class FavoritesWorker: FavoritesWorkLogic {
    func saveFovoriteCharacter(_ character: Character, image: UIImage?) {
        let data = image?.jpegData(compressionQuality: 1.0)
        MarvelDataProvider.saveFavoriteCharacter(character, image: data)
    }
    
    func deleteFavoriteCharacter(_ character: Character) {
        _ = MarvelDataProvider.deleteFavoriteCharacter(withId: character.id)
    }
    
    func loadFavoriteCharacters() -> [Character] {
        let characters = MarvelDataProvider.fetchFavoriteCharacters()
        return characters.map {$0.toCharacter()}
    }
}
