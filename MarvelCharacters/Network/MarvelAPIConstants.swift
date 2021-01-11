//
//  MarvelAPIConstants.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 10/01/21.
//

import Foundation

struct MarvelAPIConstants {
    
    static let BASE_URL = "https://gateway.marvel.com:443/v1/public/"

    static let PUBLIC_KEY = "5ad16feab35d3d17b363c0610cbebbf1"

    static let PRIVATE_KEY = "b427e67c5de72562fd483c7b00dce2487b50ff3c"

    static let PARAMETER_PUBLIC_KEY = "apikey"

    static let PARAMETER_HASH = "hash"

    static let PARAMETER_TIMESTAMP = "ts"
    
    static let PARAMETER_NAME_STARTS_WITH = "nameStartsWith"
    
    static let PARAMETER_OFFSET = "offset"
    
    static let HEADER_CONTENT_TYPE_KEY = "Content-Type"
    
    static let HEADER_CONTENT_TYPE = "application/json"
}


