//
//  CharacterDetailsWorker.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 14/01/21.
//

import UIKit

enum CharacterDetailsWorkerError: Error {
    case systemUnavailable
    case custom(message: String)
    
    var localizedDescription: String {
        switch self {
        case .systemUnavailable:
            return "Sistema Indisponível"
        case .custom(let message):
            return message
        }
    }
}

protocol CharacterDetailsWorkLogic: class {

}

// MARK: Work Logic Protocol
class CharacterDetailsWorker: CharacterDetailsWorkLogic {
    
}
