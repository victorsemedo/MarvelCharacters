//
//  Character.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 10/01/21.
//

import Foundation

struct MarvelFetchListResponse<T: Codable>: Codable  {
    let data: MarvelResult<T>
}

struct MarvelResult<T: Codable>: Codable  {
    let results: [T]
}
