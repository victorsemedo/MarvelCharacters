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
}
