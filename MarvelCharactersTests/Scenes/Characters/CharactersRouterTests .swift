//
//  CharactersRouterTests .swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 19/01/21.
//

import XCTest
@testable import MarvelCharacters

class CharactersRouterTests: XCTestCase {
    // MARK: Subject under test
    var sut: CharactersRouter!
    var dataStoreSpy: CharactersInteractorSpy!
    var viewControllerSpy: CharactersViewControllerSpy!
    var navigationControllerSpy: UINavigationControllerSpy!

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        dataStoreSpy = CharactersInteractorSpy()
        viewControllerSpy = CharactersViewControllerSpy()
        navigationControllerSpy = UINavigationControllerSpy(rootViewController: viewControllerSpy)
        sut = CharactersRouter(viewController: viewControllerSpy, dataStore: dataStoreSpy)
    }
    
    override func tearDown() {
        dataStoreSpy = nil
        viewControllerSpy = nil
        navigationControllerSpy = nil
        sut = nil
        super.tearDown()
    }
    
    // MARK: Tests
    func testRouteToSomewhere() {
    }
}
