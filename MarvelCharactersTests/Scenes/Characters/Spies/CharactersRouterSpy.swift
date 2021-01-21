//
//  CharactersRouterSpy.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 19/01/21.
//

@testable import MarvelCharacters

class CharactersRouterSpy {
    var routeToDetailsCalled = false
}

extension CharactersRouterSpy: CharactersRoutingLogic {
    func routeToDetails() {
        routeToDetailsCalled = true
    }
}
