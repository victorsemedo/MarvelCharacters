//
//  CharacterDetailsRouterSpy.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 19/01/21.
//

@testable import MarvelCharacters

class CharacterDetailsRouterSpy {
    var routeToSomewhereCalled = false
}

extension CharacterDetailsRouterSpy: CharacterDetailsRoutingLogic {
}
