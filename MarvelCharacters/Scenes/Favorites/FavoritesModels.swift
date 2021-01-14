//
//  FavoritesModels.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 13/01/21.
//

import UIKit

enum Favorites {
    enum FecthAll {
        struct Request {
        }
        
        struct Response {
            let characters: [FavoriteCharacter]
        }
        
        struct ViewModel {
            let characters: [CharactersCellProtocol]
        }
    }
}
