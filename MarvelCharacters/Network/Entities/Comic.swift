//
//  Comic.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 16/01/21.
//

import Foundation

struct Comic: Codable {
    let id: Int
    let title: String?
    let thumbnail: MarvelImage?
}
