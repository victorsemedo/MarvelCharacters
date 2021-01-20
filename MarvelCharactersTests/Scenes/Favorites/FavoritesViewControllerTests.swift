//
//  FavoritesViewControllerTests.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 19/01/21.
//

import XCTest
@testable import MarvelCharacters

class FavoritesViewControllerTests: XCTestCase {
    // MARK: Subject under test
    var sut: FavoritesViewController!
    var interactorSpy: FavoritesInteractorSpy!
    var routerSpy: FavoritesRouterSpy!
    
    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        interactorSpy = FavoritesInteractorSpy()
        routerSpy = FavoritesRouterSpy()
        sut = FavoritesViewController()
        sut.setup(interactor: interactorSpy, router: routerSpy)
    }
    
    override func tearDown() {
        interactorSpy = nil
        routerSpy = nil
        sut = nil
        super.tearDown()
    }

}
