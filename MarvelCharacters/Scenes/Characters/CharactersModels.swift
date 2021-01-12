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
    
}
