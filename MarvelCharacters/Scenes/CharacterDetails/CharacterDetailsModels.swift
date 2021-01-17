//
//  CharacterDetailsModels.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 14/01/21.
//

import UIKit

enum CharacterDetails {
    enum LoadCharacter {
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
            let isFavorite: Bool?
        }
    }
    
    enum LoadComicsSeries {
        struct Request {
        }
        struct Response {
            let comics: [Comic]
            let series: [Serie]
        }
        struct ViewModel {
            let comics: [CarouselCellProtocol]
            let series: [CarouselCellProtocol]
        }
    }
    
    enum UpdateFavorite {
        struct Request {
            let isFavorite: Bool
            let image: UIImage?
        }
        struct Response {
            let result: Bool
        }
        struct ViewModel {
            let result: Bool
        }
    }
}
