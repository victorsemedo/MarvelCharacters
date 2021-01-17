//
//  Character.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 10/01/21.
//

import Foundation
import UIKit

struct Character: Codable {
    let id: Int
    let name: String?
    let description: String?
    let thumbnail: MarvelImage?
    
    init(id: Int, name: String?, description: String?, thumbnail: MarvelImage? = nil) {
        self.id = id
        self.name = name
        self.description = description
        self.thumbnail = thumbnail
    }
    
    private enum CodingKeys : String, CodingKey {
        case id, name, description, thumbnail
    }
    
    private var _imageUrl: String? = nil
    var imageUrl: String? {
        get {
            guard let thumbnail = thumbnail else { return _imageUrl }
            return thumbnail.imageUrl
        }
        set {
            _imageUrl = newValue
        }
    }
    
    var isFavorite: Bool =  false
    
    var image: UIImage? = nil
}
