//
//  MarvelImage.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 12/01/21.
//

import Foundation

struct MarvelImage: Codable {
    let path: String?
    let fileExtension: String?
    
    private enum CodingKeys : String, CodingKey {
        case path, fileExtension = "extension"
    }
    
    var imageUrl: String? {
        guard let fileExtension = fileExtension, let path = path,
              path.count > 0, fileExtension.count > 0 else {
            return nil
        }
        return "\(path).\(fileExtension)"
    }
}

