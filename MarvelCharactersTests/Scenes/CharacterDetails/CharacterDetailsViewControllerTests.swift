//
//  CharacterDetailsViewControllerTests.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 19/01/21.
//

import XCTest
@testable import MarvelCharacters

class CharacterDetailsViewControllerTests: XCTestCase {
    // MARK: Subject under test
    var sut: CharacterDetailsViewController!
    var interactorSpy: CharacterDetailsInteractorSpy!
    var routerSpy: CharacterDetailsRouterSpy!
    
    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        interactorSpy = CharacterDetailsInteractorSpy()
        routerSpy = CharacterDetailsRouterSpy()
        sut = CharacterDetailsViewController()
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
