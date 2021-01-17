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
            let characters: [Character]
        }
        struct ViewModel {
            let characters: [CharactersCellProtocol]
        }
    }
    
    enum UpdateFavorite {
        struct Request {
            let index: Int
            let isFavorite: Bool
            let image: UIImage?
        }
        struct Response {
            let result: Bool
            let index: Int
        }
        struct ViewModel {
            let result: Bool
            let index: Int
        }
    }
    
    enum SelectCharacter {
        struct Request {
            let index: Int
        }
    }
}
