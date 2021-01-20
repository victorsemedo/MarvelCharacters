//
//  CharactersViewControllerTests.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 19/01/21.
//

import XCTest
@testable import MarvelCharacters

class CharactersViewControllerTests: XCTestCase {
    // MARK: Subject under test
    var sut: CharactersViewController!
    var interactorSpy: CharactersInteractorSpy!
    var routerSpy: CharactersRouterSpy!
    
    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        interactorSpy = CharactersInteractorSpy()
        routerSpy = CharactersRouterSpy()
        sut = CharactersViewController()
        sut.setup(interactor: interactorSpy, router: routerSpy)
    }
    
    override func tearDown() {
        interactorSpy = nil
        routerSpy = nil
        sut = nil
        super.tearDown()
    }
    
    // MARK: Tests
    func testDisplaySomething() {
    }
}
