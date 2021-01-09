//
//  CharactersWorker.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 09/01/21.
//

import UIKit

enum CharactersWorkerError: Error {
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

protocol CharactersWorkLogic: class {
    func fetchSomething(request: Characters.Something.Request,
                        result: @escaping (Result<Characters.Something.Response, CharactersWorkerError>) -> Void)
}

// MARK: Work Logic Protocol
class CharactersWorker: CharactersWorkLogic {
    func fetchSomething(request: Characters.Something.Request,
                        result: @escaping (Result<Characters.Something.Response, CharactersWorkerError>) -> Void) {
    }
}
