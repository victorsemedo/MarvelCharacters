//
//  Character.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 10/01/21.
//

import Foundation

struct CharactersResponse: Codable {
    let characters: [Character]?
    
    private enum CodingKeys : String, CodingKey {
        case characters = "results"
    }
}
