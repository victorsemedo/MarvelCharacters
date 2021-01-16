//
//  Character.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 10/01/21.
//

import Foundation

struct Character: Codable {
    let id: Int
    let name: String?
    let description: String?
    let thumbnail: MarvelImage?
    
    private enum CodingKeys : String, CodingKey {
        case id, name, description, thumbnail
    }
    
    var imageUrl: String? {
        guard let thumbnail = thumbnail else { return nil }
        return thumbnail.imageUrl
    }
    
}
