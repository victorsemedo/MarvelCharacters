//
//  Serie.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 16/01/21.
//

import UIKit

struct Serie: Codable {
    let id: Int
    let title: String?
    let thumbnail: MarvelImage?
    
    private enum CodingKeys : String, CodingKey {
        case id, title, thumbnail
    }
    
    var image: UIImage? = nil
    
    var imageUrl: String? {
        return thumbnail?.imageUrl
    }
}
