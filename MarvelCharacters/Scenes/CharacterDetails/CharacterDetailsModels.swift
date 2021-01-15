//
//  CharacterDetailsModels.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 14/01/21.
//

import UIKit

enum CharacterDetails {
    enum LoadData {
        struct Request {
        }
        
        struct Response {
            let character: Character?
        }
        
        struct ViewModel {
            let name: String?
            let description: String?
            let imageUrl: String?
            let image: UIImage?
        }
    }
}
