//
//  CharactersModels.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 09/01/21.
//

import UIKit

enum Characters {
    
    enum LoadNextPage {
        struct Request {
            let page: Int
            let searchName: String?
            let reset: Bool
        }
        struct Response {
            let characters: [Character]
        }
        struct ViewModel {
            let characters: [CharactersCellProtocol]
            let emptyType: CharactersEmptyType?
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
    
    enum ReloadFavorites {
        struct Request {
        }
    }
}

extension Character: CharactersCellProtocol {}
