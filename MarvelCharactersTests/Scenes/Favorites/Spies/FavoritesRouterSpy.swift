//
//  FavoritesRouterSpy.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 19/01/21.
//

@testable import MarvelCharacters

class FavoritesRouterSpy {
    var routeToDetailsCalled = false
}

extension FavoritesRouterSpy: FavoritesRoutingLogic {
    
    func routeToDetails() {
        routeToDetailsCalled = true
    }    
}
