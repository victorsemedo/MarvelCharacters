//
//  Character.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 10/01/21.
//

import Foundation

struct Character: Codable {
    var id: Int
    var name: String?
    var description: String?
    var thumbnail: MarvelImage?
}
