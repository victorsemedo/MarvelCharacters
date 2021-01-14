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
        
        struct Response: Codable {
            let data: CharactersResponse
        }
        
        struct ViewModel {
            let characters: [CharactersCellProtocol]
        }
    }
    
    enum UpdateFavorite {
        struct Request {
            let index: Int
            let isFavorite: Bool
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
}

class CharacterCellData: CharactersCellProtocol {
    
    let character: Character
    
    var name: String? {
        return character.name
    }
    
    var imageUrl: String? {
        return "\(character.thumbnail?.path ?? "").\(character.thumbnail?.fileExtension ?? "")"
    }
    
    var isFavorite: Bool = false
    
    init(character: Character) {
        self.character = character
    }
}
